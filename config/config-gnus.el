(require 'nnir)
(require 'gnus-diary)
(require 'nndiary)

(use-package bbdb
  :ensure t)

(use-package gnus
  :demand t
  :hook ((gnus-group-mode . gnus-topic-mode)
	 (message-mode . flyspell-mode)
	 (message-mode . (lambda ()
			   (local-set-key (kbd "<tab>") 'bbdb-complete-mail)))
	 (gnus-group-mode . hl-line-mode)
	 (gnus-group-mode . (lambda ()
	 		  (hl-line-mode 1)
	 		  (set (make-local-variable 'line-move-visual) nil)
	 		  (setq cursor-type nil)))
	 (gnus-startup . bbdb-insinuate-gnus))
  :custom
  (bbdb/news-auto-create-p t)
  (nndiary-get-new-mail t)
  (nnimap-sequence 1)
  (mail-use-agent 'gnus-user-agent)
  (gnus-novice-user nil)  
  (gnus-secondary-select-methods
   '((nnimap "gmail-primary"
	     (nnimap-address "imap.gmail.com")
	     (nnimap-server-port "imaps")
	     (nnir-search-engine imap)
	     (nnimap-stream ssl))
     (nnimap "yahoo-primary"
	     (nnnimap-address "imap.mail.yahoo.com")
	     (nnimap-server-port "imaps")
	     (nnir-search-engine imap)
	     (nnimap-stream ssl))
     (nnimap "gmail-personal"
	     (nnimap-address "imap.gmail.com")
	     (nnimap-server-port "imaps")
	     (nnir-search-engine imap)
	     (nnimap-stream ssl))
     (nndiary "diary")))
  (gnus-select-method '(nntp "news.gwene.org"))
  (smtpmail-smtp-server "smtp.gmail.com")
  (smtpmail-smtp-service 587)
  (gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
  (epa-file-cache-passphrase-for-symmetric-encryption t)
  (gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date
				gnus-sort-by-rank
				(not gnus-thread-sort-by-number)))
  (gnus-group-line-format "%P %-4N %(%~(pad-right 8)G%)\n")
  (gnus-topic-line-format "%i[ %0{%(%n (new: %a)%)%} ]\n")
  (gnus-summary-line-format ":%U%R| %5,5k/%5,5L | %20,20&user-date; | %-30,30n | %B%s\n")
  (message-citation-line-function 'message-insert-formatted-citation-line)
  (gnus-sum-thread-tree-indent " ")
  (gnus-sum-thread-tree-root "\u250c\u25e6 ")
  (gnus-sum-thread-tree-false-root " \u25cc ")
  (gnus-sum-thread-tree-single-indent " \u25e6 ")
  (gnus-sum-thread-tree-leaf-with-other "\u251c\u2500\u2500\u25b8 ")
  (gnus-sum-thread-tree-vertical "\u2502")
  (gnus-sum-thread-tree-single-leaf "\u2514\u2500\u2500\u25b8 ")
  (gnus-use-cache t)
  (gnus-always-read-dribble-file t)
  (nnmail-treat-duplicates 'delete)
  (gnus-save-all-headers t)
  (mail-sources nil)
  (gnus-fetch-old-headers t)
  (gnus-message-archive-group
   '((if (message-news-p)
  	 "Sent-News"
       "Sent-Mail")))
  (gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject)
  (gnus-thread-hide-subtree t)
  (gnus-thread-ignore-subject t)
  (gnus-use-correct-string-widths nil)
  :config
  ;; +----+--------------+
  ;; |    |              |
  ;; |    |--------------+
  ;; |    |              |
  ;; |    |              |
  ;; +----+--------------+
  (gnus-add-configuration
   '(article
     (horizontal 1.0
		 (vertical 25
			   (group 1.0))
		 (vertical 1.0
			   (summary 0.25 point)
			   (article 1.0)))))
  (gnus-add-configuration
   '(summary
     (horizontal 1.0
		 (vertical 25
			   (group 1.0))
		 (vertical 1.0
			   (summary 1.0 point))))))

(provide 'config-gnus)
