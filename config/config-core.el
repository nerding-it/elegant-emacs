(use-package emacs    	     
  :demand t
  :requires subr-x
  :custom
  (inhibit-splash-screen t)
  (inhibit-startup-message t)
  (create-lockfiles nil)
  (backup-directory-alist `((".*" . ,mine-cache-directory)))
  (auto-save-file-name-transforms `((".*" , mine-cache-directory)))
  (user-full-name (string-trim (shell-command-to-string "git config --global user.name")))
  (user-mail-address (string-trim (shell-command-to-string "git config --global user.email")))  
  :config
  (set-language-environment "UTF-8")
  (set-default-coding-systems 'utf-8)
  (prefer-coding-system 'utf-8))

(provide 'config-core)
