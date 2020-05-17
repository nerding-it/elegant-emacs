(use-package ido
  :demand t
  :bind (("C-x b" . ido-switch-buffer)
	 ("C-x r b" . (lambda (bname)
		      (interactive (list (ido-completing-read "Bookmark: " (bookmark-all-names) nil t)))
		      (bookmark-jump bname))))		      
  :custom
  (ido-enable-prefix nil)
  (ido-use-virtual-buffers t)
  (ido-enable-flex-matching t)
  (ido-create-new-buffer 'always)
  (ido-save-directory-list-file (expand-file-name "ido.last" mine-cache-directory))
  :config
  (ido-mode 1))

(use-package simple
  :demand t
  :bind
  (("M-x" . (lambda ()
	      (interactive)
	      (call-interactively
	       (intern
		(ido-completing-read
		 "M-x "
		 (all-completions "" obarray 'commandp))))))))

(provide 'config-ido)
