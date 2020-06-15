(use-package auctex
  :defer t
  :ensure t)

(use-package latex
  :requires auctex
  :hook ((LaTeX-mode . turn-on-reftex))
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
			       (append org-babel-load-languages
				       '((latex . t)))))

(provide 'config-tex)
