(use-package windmove
  :config
  (windmove-default-keybindings 'meta))

(use-package winner
  :bind (("<XF86Back>" . winner-undo)
	 ("<XF86Forward>" . winner-redo))
  :init
  (winner-mode))

(provide 'config-windows)
