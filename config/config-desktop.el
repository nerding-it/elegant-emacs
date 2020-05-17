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

(provide 'config-desktop)
