(use-package ibuffer
  :bind (("C-x C-b" . ibuffer-list-buffers))
  :demand t
  :config
  (add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode))

(provide 'config-buffer)
