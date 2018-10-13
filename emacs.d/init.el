(setq CONFIGURATION-PATH (expand-file-name "~/.emacs.d"))

(require 'package)
(package-initialize)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
;;fixes for getting melpa
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; always compile packages and use latest
(use-package auto-compile
  :ensure t
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))


(require 'cask "~/.cask/cask.el")
(cask-initialize)

(desktop-save-mode 0) ;; helps to keep desktop restore last window.

(load "~/.emacs.d/development/_init")
(load "~/.emacs.d/display/_init")
(load "~/.emacs.d/editing/_init")
(load "~/.emacs.d/navigation/_init")
(load "~/.emacs.d/_org_init")
(setq load-prefer-newer t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-rpc-backend "jedi")
 '(flycheck-c/c++-googlelint-executable "~/.emacs.d/development/c/cpplint.py")
 '(flycheck-googlelint-filter
   "-,+whitespace,-whitespace/braces,-whitespace/newline,-whitespace/comments,+build/include_what_you_use,+build/include_order,+readability/todo")
 '(flycheck-googlelint-linelength "120")
 '(flycheck-googlelint-root "~/dev/")
 '(flycheck-googlelint-verbose "0")
 '(package-selected-packages
   (quote
    (expand-region use-package undo-tree treemacs switch-window sublime-themes spacemacs-theme solarized-theme smex smartparens rainbow-delimiters py-autopep8 powerline popup-kill-ring pdf-tools org-bullets moe-theme markdown-mode latex-extra jedi idle-highlight-mode helm-themes helm-projectile helm-ls-git helm-flycheck helm-ctest helm-bibtex flycheck-irony elpy ein dtrt-indent dracula-theme doom-themes dashboard darktooth-theme company-statistics company-rtags company-quickhelp company-irony-c-headers company-irony color-theme-solarized color-theme-sanityinc-tomorrow color-theme-modern cmake-ide better-defaults beacon autopair afternoon-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
