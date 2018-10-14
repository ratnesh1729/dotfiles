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
;;(package-refresh-contents) ;; uncomment this if you want to refresh to latest of packages
(load "~/.emacs.d/development/_init")
(load "~/.emacs.d/display/_init")
(load "~/.emacs.d/editing/_init")
(load "~/.emacs.d/navigation/_init")
(load "~/.emacs.d/_org_init")
(setq load-prefer-newer t)
