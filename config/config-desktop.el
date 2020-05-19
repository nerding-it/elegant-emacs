(use-package bookmark
  :custom
  (bookmark-default-file (expand-file-name "bookmarks" mine-cache-directory))
  (bookmark-save-flag 1))

(use-package recentf
  :demand t
  :custom
  (recentf-save-file (expand-file-name "recentf" mine-cache-directory))
  (recentf-auto-cleanup 300)
  :config
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
  (add-to-list 'recentf-exclude ".*elpa.*autoloads\.el$")
  :init
  (recentf-mode t))

(use-package savehist
  :demand t
  :custom
  (savehist-file (expand-file-name "savehist" mine-cache-directory))
  (savehist-additional-variables '(search ring regexp-search-ring))
  (savehist-autosave-interval 60)
  (history-length 1000)
  :config
  (savehist-mode))

(use-package saveplace
  :demand t
  :custom
  (save-place-file (expand-file-name "places" mine-cache-directory))
  :config
  (setq-default save-place t))

(use-package desktop
  :custom
  (desktop-path (list mine-cache-directory))
  (desktop-dirname mine-cache-directory)
  (desktop-base-file-name "emacs-desktop")    
  (desktop-buffers-not-to-save
   (concat "\\("
           "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
           "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
	   "\\)$"))
  :config
  (add-hook 'desktop-after-read-hook
	    '(lambda ()
	       ;; desktop-remove clears desktop-dirname
	       (setq desktop-dirname-tmp desktop-dirname)
	       (desktop-remove)
	       (setq desktop-dirname desktop-dirname-tmp)))    
  (add-to-list 'desktop-globals-to-save 'register-alist)
  (add-to-list 'desktop-modes-not-to-save 'dired-mode)
  (add-to-list 'desktop-modes-not-to-save 'Info-mode)
  (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
  (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)    
  (desktop-save-mode 1))


(provide 'config-desktop)
