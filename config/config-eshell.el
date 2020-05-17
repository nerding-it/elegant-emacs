(use-package eshell
  :bind (("C-c h" . (lambda ()
			(interactive)
			(insert
			 (ido-completing-read "Eshell history: "
					      (delete-dups
					       (ring-elements eshell-history-ring))))))
	 ("C-c C-h" . 'eshell-list-history))
  :config
  (setenv "PAGER" "cat")
  :custom
  (eshell-aliases-file (expand-file-name ".eshell_aliases" user-emacs-directory)))

(provide 'config-eshell)
