(load "~/.emacs.d/display/visual.el")
(load "~/.emacs.d/display/text-display.el")
(defvar myDispPackages
  '(color-theme-modern
    sublime-themes
    doom-themes
    powerline
    afternoon-theme
    autothemer
    darktooth-theme
    helm-themes
    spacemacs-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myDispPackages)

;;add rainbow mode for braces
(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode +1))

(require 'helm-config)
(require 'helm-themes)
(use-package powerline
  :ensure t
  :init
  :config
  (powerline-default-theme))

(load-theme 'darktooth t)

;; zoom in/out
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-+") 'text-scale-increase)
;;install beacon and global line mode
(setq scroll-conservatively 100)
(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))


;;add for initial dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Hello!")
  (setq dashboard-startup-banner "~/.emacs.d/display/photos/p2.png"))

;;(global-linum-mode t) ;; disable this if you do not want line num mode

;; add clock color theme
(load "~/.emacs.d/display/sky-color-clock/sky-color-clock.el")
(sky-color-clock-initialize 37.2876)
(push '(:eval (sky-color-clock)) (default-value 'mode-line-format))
;;(sky-color-clock-initialize-openweathermap-client "API-Key" 5333689) ;; put your API key and city ID and UNCOMMENT THIS LINE.. refer to sky-color clock page
(setq sky-color-clock-format "%d/%m %H:%M")
