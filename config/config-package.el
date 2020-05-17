(use-package package
  :demand t
  :custom
  (package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
		      ("melpa" . "https://melpa.org/packages/")))
  :config
  (package-initialize))

(provide 'config-package)
