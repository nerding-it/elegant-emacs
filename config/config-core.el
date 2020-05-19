(use-package emacs    	     
  :demand t
  :custom
  (inhibit-splash-screen t)
  (inhibit-startup-message t)
  (create-lockfiles nil)
  (backup-directory-alist `((".*" . ,mine-cache-directory)))
  (auto-save-file-name-transforms `((".*" , mine-cache-directory)))
  (browse-url-browser-function 'eww-browse-url)
  :config
  (set-language-environment "UTF-8")
  (set-default-coding-systems 'utf-8)
  (prefer-coding-system 'utf-8))

(require 'subr-x)
(setq user-full-name (string-trim (shell-command-to-string "git config --global user.name")))
(setq user-mail-address (string-trim (shell-command-to-string "git config --global user.email")))

(provide 'config-core)
