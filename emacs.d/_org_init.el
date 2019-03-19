;;configurations for org mode
(use-package org-bullets
  :ensure t
  :init)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-agenda-files (list "~/.emacs.d/tasks_notes.org")) ;;probably not needed as we can use command to add in agenda list
(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-ellipsis "⤵") ;; setting downward arrow than ellipsis
(setq org-src-fontify-natively t) ;; use syntax highlighting in source blocks
(setq org-src-tab-acts-natively t) ;; use TAB as if it is issued in language's major mode
(add-hook 'org-mode-hook 'flyspell-mode) ;; enable spell check
;; THE FOLLOWING COULD NOT WORK ON 18.04
;;(add-to-list 'org-structure-template-alist
;;             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC")) ;; helps in quickly inserting a block of elisp


