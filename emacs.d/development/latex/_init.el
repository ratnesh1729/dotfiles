;; mostly taken from http://nasseralkmim.github.io/notes/2016/08/21/my-latex-environment/
;; also details from here - https://piotrkazmierczak.com/2010/emacs-as-the-ultimate-latex-editor/
;; for using latex mode extra - https://github.com/Malabarba/latex-extra/issues/23
(use-package smartparens
  :ensure t)
(require 'smartparens-config)

(add-hook 'tex-mode-hook #'smartparens-mode)

(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (rainbow-delimiters-mode)
              (company-mode)
              (smartparens-mode)
              (turn-on-reftex)
              (setq reftex-plug-into-AUCTeX t)
              (reftex-isearch-minor-mode)
              (setq TeX-PDF-mode t)
              (setq TeX-source-correlate-method 'synctex)
              (setq TeX-source-correlate-mode t)
              (setq TeX-source-correlate-start-server t)))

;; Update PDF buffers after successful LaTeX runs
;;(add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
  ;;          #'TeX-revert-document-buffer)
  
;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)

;; to use pdfview with auctex
(add-hook 'LaTeX-mode-hook 'pdf-tools-install)

;; to use pdfview with auctex
(setq TeX-view-program-selection '((output-pdf "pdf-tools"))
       TeX-source-correlate-start-server t)
(setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))))

;; also use reftex that helps inserting labels, references and citations.
(use-package reftex
  :ensure t
  :defer t
  :config
  (setq reftex-cite-prompt-optional-args t)); Prompt for empty optional arguments in cite

;; Important configuration - helm-bibtex - for managing references and else
(use-package helm-bibtex
  :ensure t
  :bind ("C-c b b" . helm-bibtex)
  :config
  (setq bibtex-completion-bibliography 
        '("/home/ratneshk/Documents/Mendeley_Desktop/bibtex/library.bib"))
  (setq bibtex-completion-library-path 
        '("/home/ratneshk/Documents/Mendeley_Desktop/"
          "/home/ratneshk/Documents/Mendeley_Desktop/"))

  ;; using bibtex path reference to pdf file
  (setq bibtex-completion-pdf-field "File")

  ;;open pdf with external viwer evince
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (call-process "evince" nil 0 nil fpath)))

 (setq helm-bibtex-default-action 'bibtex-completion-insert-citation))


;;pdf tools -helps move from one section to another.
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-tools-install)
  ;;:bind ("C-c C-g" . pdf-sync-forward-search)
  :defer t
  :config
  (setq mouse-wheel-follow-mouse t)
  (setq pdf-view-resize-factor 1.10))

(add-hook 'pdf-view-mode (lambda () (linum-mode nil)))
;;compilation
(add-hook 'LaTeX-mode-hook
     '(lambda()
     (local-set-key (kbd "<f1>") 'TeX-master-command)
     ))

;;(add-hook 'LaTeX-mode-hook #'latex-extra-mode)
(use-package latex-extra
  :ensure t
  :hook (LaTeX-mode . latex-extra-mode))
