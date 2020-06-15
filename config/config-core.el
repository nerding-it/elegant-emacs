(use-package emacs    	     
  :demand t
  :custom
  (inhibit-splash-screen t)
  (inhibit-startup-message t)
  (create-lockfiles nil)
  (backup-directory-alist `((".*" . ,mine-cache-directory)))
  (auto-save-file-name-transforms `((".*" , mine-cache-directory)))
  (browse-url-browser-function 'eww-browse-url))

(use-package simple
  :custom
  (kill-ring-max (* 4 2048)))

(global-unset-key (kbd "C-x C-c"))
(defun mine/exit-emacs ()
  (interactive)
  (message "You can't quit emacs"))
(global-set-key (kbd "C-x C-c") 'mine/exit-emacs)

(require 'subr-x)
(setq user-full-name (string-trim (shell-command-to-string "git config --global user.name")))
(setq user-mail-address (string-trim (shell-command-to-string "git config --global user.email")))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(setq indent-tabs-mode nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'config-core)
