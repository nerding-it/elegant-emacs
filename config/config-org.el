(use-package org
  :config
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)  
  :custom
  (org-confirm-babel-evaluate nil)
  (org-directory mine-second-brain-location)
  (diary-file (expand-file-name "diary" org-directory))
  (org-use-speed-commands t)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-timestamp-if-done t)
  (org-agenda-start-on-weekday 1)

  ;; Agenda files
  (org-agenda-files (list
		     (expand-file-name "inbox.org" org-directory)
		     (expand-file-name "gtd.org" org-directory)
		     (expand-file-name "tickler.org" org-directory)))
  ;; Add UTF-8 Symbols
  (org-tag-alist '((:startgrouptag)
		   (:grouptags)
		   ("@work" . ?w)
		   ("@home" . ?h)
		   (:endgrouptag)
		   (:grouptags)
		   ("research" . ?R)
		   ("coding" . ?C)
		   ("writing" . ?W)
		   (:grouptags)
		   ("crypt" . ?c)
		   (:endgrouptag)
		   (:grouptags)
		   ("WAIT" . ?W)
		   ("STOP" . ?C)
		   (:endgrouptag)))

  (org-use-fast-todo-selection t)
  ;; TODO -> DONE
  ;; WAIT -> STOP
  (org-todo-keywords '((sequence "TODO(t)" "|" "DONE(d)")
		       (sequence "WAIT(w@)" "|" "STOP(c@)")))
  (org-todo-state-tags-triggers '(
				  ;; Moving to wait adds wait
				  ("WAIT" ("WAIT" . t))
				  ;; Moving to stop adds stop, removes wait
				  ("STOP" ("STOP" . t))
				  ;; Moving to done removes wait/stop
				  ("DONE" ("WAIT") ("STOP"))
				  ;; Moving to todo removes wait/stop
				  ("TODO" ("WAIT") ("STOP"))))

  (org-crypt-key epa-file-encrypt-to)
  (org-crypt-use-before-save-magic)
  (org-tags-exclude-from-inheritance '("crypt"))
  (org-agenda-include-diary t)

  (org-capture-templates `(
			   ("t" "TODO" entry (file+headline , (expand-file-name "inbox.org" org-directory) "TASKS") "* ❢ %?\n %i\n")
			   ("a" "ARTICLE" plain (file (lambda ()
							(let* ((title (read-string "Title: "))
							       (slug (replace-regexp-in-string
								      "[^a-z]+" "-" (downcase title)))
							       (dir (expand-file-name "articles" org-directory)))
							  (unless (file-exists-p dir)
							    (make-directory dir))
							  (expand-file-name (concat slug ".org") dir)))) "#+TITLE: %^{Title}\n#+DATE: %<%Y-%m-%d>"))))

(provide 'config-org)
