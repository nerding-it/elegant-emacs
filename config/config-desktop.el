(defun mine/ido-recentf-open ()
  "Open recent files"
  (interactive)
  (let ((file
	 (ido-completing-read "Recent: " recentf-list)))
    (find-file file)))

(use-package bookmark
  :custom
  (bookmark-default-file (expand-file-name "bookmarks" mine-cache-directory))
  (bookmark-save-flag 1))

(use-package recentf
  :demand t
  :bind (("C-x C-r" . mine/ido-recentf-open))
  :custom
  (recentf-save-file (expand-file-name "recentf" mine-cache-directory))
  (recentf-max-saved-items nil)
  :config
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
  (add-to-list 'recentf-exclude ".*elpa.*autoloads\.el$")
  (run-at-time nil (* 5 120) 'recentf-save-list)
  :init
  (recentf-mode t))

(use-package savehist
  :demand t
  :custom
  (savehist-file (expand-file-name "savehist" mine-cache-directory))
  (savehist-additional-variables '(search ring regexp-search-ring ))
  (savehist-autosave-interval 60)
  :config
  (savehist-mode))

(use-package saveplace
  :demand t
  :custom
  (save-place-limit nil)
  (save-place-file (expand-file-name "places" mine-cache-directory))
  :config
  (setq-default save-place t))

(use-package desktop
  :demand t
  :bind (("s-d" . mine/session-save)
	 ("s-b" . mine/session-restore))
  :hook ((desktop-after-read . (lambda ()
				(setq desktop-dirname-tmp desktop-dirname)
				(desktop-remove)
				(setq desktop-dirname desktop-dirname-tmp)))
	 (auto-save . (lambda ()
			(if (eq (desktop-owner) (emacs-pid))
			    (desktop-save desktop-dirname))))
	 (after-init . mine/session-restore)
	 (kill-emacs . mine/session-save))
  :config
  (setq desktop-path (list mine-cache-directory))
  (setq desktop-dirname mine-cache-directory)
  (setq desktop-base-file-name ".emacs.desktop")
  (setq history-length 2048)
  (setq desktop-buffers-not-to-save
   (concat "\\("
           "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
           "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
	   "\\)$"))
  (setq desktop-load-locked-desktop nil)  
  (defun mine/session-save ()
    "Save an emacs session."
    (interactive)
    (if (file-exists-p (expand-file-name desktop-base-file-name desktop-dirname))
	(if (y-or-n-p "Overwrite session? ")
	    (desktop-save-in-desktop-dir)
	  (message "Aborting."))))

  (defun mine/session-restore ()
    "Restore a saved emacs session."
    (interactive)
    (if (file-exists-p (expand-file-name desktop-base-file-name desktop-dirname))
	(desktop-read)
      (message "No session found")))
  
  (add-to-list 'desktop-globals-to-save 'register-alist)
  (add-to-list 'desktop-globals-to-save 'kill-ring)
  (add-to-list 'desktop-globals-to-save 'regexp-search-ring)
  (add-to-list 'desktop-globals-to-save 'search-ring)
  (add-to-list 'desktop-globals-to-save 'kmacro-ring)
  (add-to-list 'desktop-modes-not-to-save 'dired-mode)
  (add-to-list 'desktop-modes-not-to-save 'Info-mode)
  (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
  (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)  
  (desktop-save-mode 1))

(provide 'config-desktop)
