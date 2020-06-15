(use-package windmove
  :requires register
  :bind (("s-h" . windmove-left)
	 ("s-l" . windmove-right)
	 ("s-k" . windmove-up)
	 ("s-j" . windmove-down)
	 ("s-w" . window-configuration-to-register))
  :config
  (windmove-default-keybindings 'meta))

(use-package winner
  :custom
  (winner-ring-size 1024)
  (winner-boring-buffers '("*Completions*" "*Help" "*Apropos*" "*Buffer List*" "*Compile Log*" "*Calendar*" "*Warnings*"))
  :bind (("<XF86Back>" . winner-undo)
	 ("<XF86Forward>" . winner-redo)
	 ("s-u" . winner-undo))
  :init
  (winner-mode))

(provide 'config-windows)
