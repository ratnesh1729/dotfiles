(load "~/.emacs.d/editing/template.el")
(template-initialize)

(load "~/.emacs.d/editing/dos-unix-conversion.el")
(load "~/.emacs.d/editing/spell_check.el")
;; ========== Place Backup Files in Specific Directory ==========

;; Enable backup files.
(setq make-backup-files t)
;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)
(setq delete-old-versions t)
;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backup"))))

;; pair parenthesis
(autopair-global-mode)

;; activate undo tree
(global-undo-tree-mode)

;; mouse specific
(mouse-avoidance-mode 'jump)
(setq mouse-yank-at-point t)

;; indent after k columns
(set-default 'fill-column 120)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'latex-mode-hook 'turn-on-auto-fill)
(add-hook 'changelog-mode-hook 'turn-on-auto-fill)

(global-hi-lock-mode 1)

(global-set-key [(control meta b)] 'toggle-truncate-lines)
(global-set-key [(control z)] 'undo)
(global-set-key [(meta g)] 'goto-line)
(global-set-key [f12] 'delete-trailing-whitespace)

(add-hook 'autoconf-mode-hook   'flyspell-prog-mode)
(add-hook 'autotest-mode-hook   'flyspell-prog-mode)
(add-hook 'c++-mode-hook        'flyspell-prog-mode)
(add-hook 'c-mode-hook          'flyspell-prog-mode)
(add-hook 'cperl-mode-hook      'flyspell-prog-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)
(add-hook 'makefile-mode-hook   'flyspell-prog-mode)
(add-hook 'nxml-mode-hook       'flyspell-prog-mode)
(add-hook 'python-mode-hook     'flyspell-prog-mode)
(add-hook 'sh-mode-hook         'flyspell-prog-mode)

;(global-smart-tab-mode 1)

;; C-C copy, C-V paste, C-X cut
(cua-mode)

;; toggle rectangle mark / regular mark using C-Space
;; (global-set-key (kbd "C-SPC")
;;                 '(lambda(&optional arg) (interactive "P")
;;                    (if (or (not mark-active) arg)
;;                        (cua-set-mark arg)
;;                      (cua-toggle-rectangle-mark))))

;; allow downcase region
(put 'downcase-region 'disabled nil)

;; disable insert key
(define-key global-map [(insert)] nil)
(define-key global-map [(control insert)] 'overwrite-mode)
;;pop up kill ring
(use-package popup-kill-ring
   :ensure t
   :bind("M-y" . popup-kill-ring))

;;pdf tools
(use-package pdf-tools
  :ensure t
  :config
  ;;(pdf-tools-install) ;; uncomment first time using emacs
 ;; open pdfs scaled to fit page
 (setq-default pdf-view-display-size 'fit-page)
 ;; automatically annotate highlights
 (setq pdf-annot-activate-created-annotations t)
 ;; use normal isearch
 (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

(use-package expand-region
  :ensure t
  :config
  (define-key global-map (kbd "C-=") 'er/expand-region))
