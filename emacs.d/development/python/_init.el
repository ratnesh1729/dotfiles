;;(defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))
;; (add-hook 'python-mode-hook 'my/python-mode-hook)
;; (add-hook 'python-mode-hook 'eldoc-mode)

;; delete trailing whitespaces on save: NOT working in EIN mode - solution for other modes below
;;(add-hook 'python-mode-hook
;;          (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; checking to see if I can disable auto complete mode and get exactly one code completion
(add-hook 'python-mode-hook (lambda () (auto-complete-mode -1)))

;; testing with elpy
(defvar myPackages
  '(better-defaults
    elpy
    ein
    flycheck
    use-package
    company-quickhelp
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(use-package jedi
   :ensure t
   :init
   (setq jedi:complete-on-dot t)
   :config
   (add-hook 'python-mode-hook 'jedi:setup))


(use-package elpy
:config
(elpy-enable)
;; Don't use flymake if flycheck is available.
(when (require 'flycheck nil t)
  (setq elpy-modules
        (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; Don't use highlight-indentation-mode.
;; this is messed with by emacs if you let it...
(custom-set-variables
 '(elpy-rpc-backend "jedi"))
;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(define-key elpy-mode-map (kbd "C-c C-n") 'next-error)
(define-key elpy-mode-map (kbd "C-c C-p") 'previous-error)
;; Elpy also installs yasnippets.
;; Don't use tab for yasnippets, use shift-tab.
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)
:diminish elpy-mode
)



(add-hook 'python-mode-hook (lambda () (idle-highlight-mode t)))
;; below is for vertical function lines
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode 1)))

;; black from FAQ  https://github.com/jorgenschaefer/elpy/wiki/FAQ [company vs yasnippet]
(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))

(add-hook 'company-mode-hook
          (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
             company-active-map)))

;; ------
(use-package ein
  :ensure t
  :commands
  (ein:notebooklist-open)
  :init
  ;;(setq ein:completion-backend 'ein:use-ac-jedi-backend)
  ;;(setq ein:use-auto-complete-superpack t)
  (setq ein:completion-backend 'ein:use-company-backend)
  (setq ein:complete-on-dot t)
  :config
  (add-hook 'ein:connect-mode-hook 'ein:jedi-setup))

;;(require 'ein-dev)
;;(require 'ein-loaddefs) Somehow could not find this - maybe dependent upon some EINs
(require 'ein-notebook)
(require 'ein-subpackages)


;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
