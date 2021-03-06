(use-package scroll-bar
  :config
  (scroll-bar-mode 0))

(use-package menu-bar
  :config
  (menu-bar-mode -1))

(use-package tool-bar
  :config
  (tool-bar-mode -1))

(use-package fringe
  :config
  (fringe-mode '(nil . 0)))

(use-package frame
  :config
  (blink-cursor-mode 0))

(use-package all-the-icons
  :if (eq mine-appearance 'elegant)    
  :ensure t)

(use-package all-the-icons-dired
  :if (eq mine-appearance 'elegant)    
  :requires all-the-icons
  :after (dired all-the-icons)
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dashboard
  :if (eq mine-appearance 'elegant)  
  :requires all-the-icons
  :ensure t
  :custom
  (dashboard-banner-logo-title "Welcome to Debian/Emacs")
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-show-shortcuts nil)
  (dashboard-items '((recents . 5)
  		     (bookmarks . 5)
  		     (agenda . 5)
  		     (registers . 5)))
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-set-navigator t)
  (dashboard-set-init-info t)
  (dashboard-set-footer nil)
  (show-week-agenda-p t)
  (initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  :config
  (dashboard-setup-startup-hook))

(use-package poet-theme
  :if (eq mine-appearance 'elegant)  
  :ensure t
  :demand t
  :init
  (set-face-attribute 'default nil :family "Iosevka" :height 130)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka")
  (set-face-attribute 'variable-pitch nil :family "Iosevka")
  (load-theme 'poet t))

(use-package smart-mode-line
  :if (eq mine-appearance 'elegant)  
  :ensure t
  :custom
  (sml/no-confirm-load-theme t)
  (sml/theme 'respectful)
  :config
  (sml/setup))

(use-package olivetti
  :if (eq mine-appearance 'elegant)    
  :ensure t
  :after (poet-theme org)
  :custom
  (olivetti-body-width 100)
  :hook (org-mode . olivetti-mode))

(use-package org-bullets
  :if (eq mine-appearance 'elegant)  
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package custom
  :if (eq mine-appearance 'default)
  :config
  (set-frame-font "Hack-12")
  (load-theme 'adwaita))

(provide 'config-appearance)
