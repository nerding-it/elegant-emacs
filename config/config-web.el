(use-package csharp-mode
  :ensure t
  :mode "\\.cs\\'")

(use-package mhtml-mode
  :mode "\\.html\\'")

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

(use-package ob-typescript
  :ensure t
  :requires typescript-mode
  :after org
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
			       (append org-babel-load-languages
				       '((typescript . t)))))

(use-package js
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
			       (append org-babel-load-languages
				       '((js . t)))))  

(provide 'config-web)
