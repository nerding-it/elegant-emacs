(use-package org
  :hook (org-mode . electric-pair-mode)
  :config
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (modify-syntax-entry ?/ "(/" org-mode-syntax-table)
  (modify-syntax-entry ?= "(=" org-mode-syntax-table)
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
		   ("WAITING" . ?W)
		   ("CANCELLED" . ?C)
		   (:endgrouptag)))

  (org-use-fast-todo-selection t)
  ;; TODO -> DONE
  ;; WAIT -> STOP
  (org-todo-keywords '((sequence "TODO(t)" "|" "DONE(d)")
		       (sequence "WAIT(w@)" "|" "STOP(c@)")))
  (org-todo-state-tags-triggers '(
				  ;; Moving to wait adds wait
				  ("WAIT" ("WAITING" . t))
				  ;; Moving to stop adds stop, removes wait
				  ("STOP" ("CANCELLED" . t))
				  ;; Moving to done removes wait/stop
				  ("DONE" ("WAITING") ("CANCELLED"))
				  ;; Moving to todo removes wait/stop
				  ("TODO" ("WAITING") ("CANCELLED"))))

  (org-crypt-use-before-save-magic)
  (org-tags-exclude-from-inheritance '("crypt"))
  (org-agenda-include-diary t)

  (org-capture-templates `(
			   ("t" "TODO"
			    entry
			    (file+headline ,
			     (expand-file-name "inbox.org" org-directory) "TASKS")
			    "* TODO %?\n %i\n")
			   ("p" "POST"
			    plain
			    (file mine/capture-article)
			    (function mine/capture-article-template))))
  :config
  (defun mine/capture-article ()
    "Function to capture `article' in `org-mode'."
    (let* ((article-base-directory (expand-file-name "articles" org-directory))
	   (article-directory (expand-file-name (format-time-string "%Y/%m/%d" (current-time)) article-base-directory))
	   (title nil)
	   (slug nil))
      (unless (file-exists-p article-directory)
      	(make-directory article-directory t))
      (setq title (read-string "Title: "))
      (setq slug (replace-regexp-in-string "[^a-z]+" "_" (downcase title)))
      (expand-file-name (concat slug ".org") article-directory)))

  (defun mine/capture-article-template ()
    (concat "#+TITLE: %^{Title}\n"
	    "#+DATE: %<%Y-%m-%d>")))

(use-package ox-publish
  :custom
  (org-export-html-postamble nil)
  (org-publish-project-alist
   `(("blog"
      :base-directory ,(expand-file-name "articles" org-directory)
      :publishing-directory ,(expand-file-name "Publish" org-directory)
      :publishing-function org-html-publish-to-html
      :language "EN"
      :make-index t
      :section-numbers nil
      :preserve-breaks nil
      :with-toc nil
      :with-latex t
      :auto-sitemap t
      :html-preamble t
      :with-footnotes nil
      :with-creator nil
      :recursive t))))

(provide 'config-org)
