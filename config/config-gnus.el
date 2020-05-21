(use-package gnus
  :requires nnir
  :hook ((gnus-group-mode-hook . gnus-topic-mode)
	 (message-mode-hook . flyspell-mode))
  :custom
  (gnus-sectondary-select-methods
   '((nnimap "gmail"
	     (nnimap-address "imap.gmail.com")
	     (nnimap-server-port "imaps")
	     (nnir-search-engine imap)
	     (nnimap-stream ssl))))
  (gnus-select-method '(nntp "news.gwene.org"))
  (smtpmail-smtp-server "smtp.gmail.com")
  (smtpmail-smtp-service 587)
  (gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
  (epa-file-cache-passphrase-for-symmetric-encryption t)
  (gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date
				(not gnus-thread-sort-by-number)))

  (gnus-use-cache t)
  (gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject)
  (gnus-thread-hide-subtree t)
  (gnus-thread-ignore-subject t)
  (gnus-use-correct-string-widths nil))
    
(provide 'config-gnus)
