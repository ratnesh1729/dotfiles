(require 'cc-mode)

;;if(0)          becomes        if (0)
;;  {                           {
;;     ;                           ;
;;  }                           }
;;(c-set-offset 'substatement-open 0)

;; do not indent namespaces
(c-set-offset 'innamespace 0)

;;
;; better
;; (setq c-mode-hook
;;        '(lambda ()
;;        (c-set-style "K&R")))

;;(setq c-basic-offset 4)
;;install more packages
(defvar myCPackages
  '(cmake-ide
    flycheck-irony
    flycheck
    company-irony
    company-irony-c-headers
    idle-highlight-mode
    autopair
    company-quickhelp
    undo-tree
    smex
    dtrt-indent
    company-statistics))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myCPackages)

;; auto-indent based on file
(add-hook 'c-mode-common-hook
  (lambda()
    (require 'dtrt-indent)
    (dtrt-indent-mode t)))

;; delete trailing whitespaces on save
(add-hook 'c-mode-common-hook
          (lambda () (add-to-list
                      'write-file-functions
                      'delete-trailing-whitespace)))



;; public void veryLongMethodNameHereWithArgs(
;;          String arg1,
;;          String arg2,
;;          int arg3)
(defconst my-c-lineup-maximum-indent 60)
(defun my-c-lineup-arglist (langelem)
  (let ((ret (c-lineup-arglist langelem)))
    (if (< (elt ret 0) my-c-lineup-maximum-indent)
        ret
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) 8))))))
(defun my-indent-setup ()
  (setcdr (assoc 'arglist-cont-nonempty c-offsets-alist)
          '(c-lineup-gcc-asm-reg my-c-lineup-arglist)))

(defun c-reformat-buffer()
  (interactive)
  (save-buffer)
  (setq sh-indent-command
        (concat
         "indent -st -bad"
         " --blank-lines-after-procedures "
         "-bli0 -i4 -l79 -ncs -npcs -nut -npsl -fca "
         "-lc79 -fc1 -cli4 -bap -sob -ci4 -nlp "
         buffer-file-name
         ))
  (mark-whole-buffer)
  (universal-argument)
  (shell-command-on-region
   (point-min)
   (point-max)
   sh-indent-command
   (buffer-name)
   )
  (save-buffer)
  )

(define-key c-mode-map [(f7)] 'c-reformat-buffer)
(define-key c++-mode-map [(f7)] 'c-reformat-buffer)

;; read h header as c++ file
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun add-custom-keyw()
  "adds a few special keywords for c and c++ modes"
  (font-lock-add-keywords nil
     '(("\\<\\(nullptr\\)" . 'font-lock-keyword-face)
       ("\\<\\(override\\)" . 'font-lock-keyword-face)
       ("\\<\\(thread_local\\)" . 'font-lock-keyword-face)
       )
     )
  )
(add-hook 'c++-mode-hook 'add-custom-keyw)

;; setup cmake-ide with rtags
;; rtags provides code navigation, cmake-ide automatic setup
(defsubst string-empty-p (string)
  "Check whether STRING is empty."
  (string= string ""))
(require 'rtags)
(cmake-ide-setup)

;;commenting below to use rtags default bindings
;;(define-key c++-mode-map (kbd "C-j") 'rtags-find-symbol-at-point)
;;(define-key c++-mode-map [C-down-mouse-1] 'rtags-find-symbol-at-point)
;;(define-key c++-mode-map (kbd "C-f") 'rtags-find-references-at-point)
;;(define-key c++-mode-map (kbd "C-l") 'rtags-find-virtuals-at-point)
;;(define-key c++-mode-map (kbd "C-r") 'rtags-rename-symbol)
(eval-after-load 'cc-mode
  '(progn
     (require 'rtags)
     (mapc (lambda (x)
             (define-key c-mode-base-map
               (kbd (concat "C-c r " (car x))) (cdr x)))
           '(("." . rtags-find-symbol-at-point)
             ("," . rtags-find-references-at-point)
             ("v" . rtags-find-virtuals-at-point)
             ("V" . rtags-print-enum-value-at-point)
             ("/" . rtags-find-all-references-at-point)
             ("Y" . rtags-cycle-overlays-on-screen)
             (">" . rtags-find-symbol)
             ("<" . rtags-find-references)
             ("-" . rtags-location-stack-back)
             ("+" . rtags-location-stack-forward)
             ("D" . rtags-diagnostics)
             ("G" . rtags-guess-function-at-point)
             ("p" . rtags-set-current-project)
             ("P" . rtags-print-dependencies)
             ("e" . rtags-reparse-file)
             ("E" . rtags-preprocess-file)
             ("R" . rtags-rename-symbol)
             ("M" . rtags-symbol-info)
             ("S" . rtags-display-summary)
             ("O" . rtags-goto-offset)
             (";" . rtags-find-file)

             ("F" . rtags-fixit)
             ("X" . rtags-fix-fixit-at-point)
             ("B" . rtags-show-rtags-buffer)
             ("I" . rtags-imenu)
             ("T" . rtags-taglist)))))


;; setup flycheck with cpplint and compilation validation via irony
(add-hook 'c++-mode-hook 'flycheck-mode)
(custom-set-variables
 '(flycheck-c/c++-googlelint-executable
   "~/.emacs.d/development/c/cpplint.py"))

(load "~/.emacs.d/development/c/flycheck-google-cpplint")
(require 'flycheck-irony)
(eval-after-load 'flycheck
  '(progn
     (require 'flycheck-google-cpplint)
     ;; Add Google C++ Style checker.
     ;; In default, syntax checked by Clang and Cppcheck.
     (flycheck-add-next-checker 'irony
                                '(warning . c/c++-googlelint))))

;(require 'flycheck-google-cpplint)
;(flycheck-add-next-checker 'irony
;                           'c/c++-googlelint)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(custom-set-variables
 '(flycheck-googlelint-verbose "0")
 '(flycheck-googlelint-filter "-,+whitespace,-whitespace/braces,-whitespace/newline,-whitespace/comments,+build/include_what_you_use,+build/include_order,+readability/todo")
 '(flycheck-googlelint-linelength "120")
 '(flycheck-googlelint-root "~/dev/")) ; warning cpplint works better it is the root of the project is correctly setup


;;configure company
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up company with RTAGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar CompanyRtagsPackages
  '(company-rtags))
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      CompanyRtagsPackages)

(global-company-mode)
(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))


;; Zero delay when pressing tab
;;(setq company-idle-delay 0)  disabling these 2 lines as I want to use tab for indenting
;;(define-key c-mode-map [(tab)] 'company-complete)
;;(define-key c++-mode-map [(tab)] 'company-complete)
;; Delay when idle because I want to be able to think
(setq company-idle-delay 0.2)

;; adding ways to configure rtags and eldoc
(defun rtags-eldoc-function ()
  (let ((summary (rtags-get-summary-text)))
    (and summary
         (fontify-string
          (replace-regexp-in-string
           "{[^}]*$" ""
           (mapconcat
            (lambda (str) (if (= 0 (length str)) "//" (string-trim str)))
            (split-string summary "\r?\n")
            " "))
          major-mode))))

;; configure Company completion for c/c++ [Uncomment below if you also want IRONY to work with company]
;; rtags provides completion but surprisingly less good than irony TODO: check code
;; cmake_ide is supposed to setup completion with irony TODO: check what is done exactly
;;(require 'company-irony)
;;(require 'company-irony-c-headers)
;;(defun my/company-irony-mode-hook ()
;;  (add-to-list 'company-backends '(company-irony-c-headers company-irony)))
;;(add-hook 'c-mode-common-hook 'my/company-irony-mode-hook)
;;(add-hook 'c-mode-common-hook 'irony-mode)

;; find compilation database generated with 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .'
;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; add contextual information in echo buffer
;;(add-hook 'irony-mode-hook 'irony-eldoc)
