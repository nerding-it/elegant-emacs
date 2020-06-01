(use-package debbugs
  :ensure t)

(use-package which-key
  :ensure t
  :custom
  (which-key-side-window-max-height 0.9)
  (max-mini-window-height 10)
  :config
  (which-key-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(provide 'config-misc)
