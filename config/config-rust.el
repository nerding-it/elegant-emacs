;;; -*- lexical-binding: t; -*-
(defvar rust--flymake-proc nil)
(defun rust-flymake-backend (report-fn &rest args)
  "Flymake backend function for rust"
  (flymake-log :debug "Starting flymake rust backend")
  (when (process-live-p rust--flymake-proc)
    (kill-process rust--flymake-proc))
  (let ((source (current-buffer)))
    (save-restriction
      (widen)
      (setq
       rust--flymake-proc
       (make-process
	:name "rust-flymake" :noquery t :connection-type 'pipe
	:buffer (generate-new-buffer " *rust flymake*")
	:command '("cargo" "check")
	:sentinel
	(lambda (proc event)
	  (when (eq 'exit (process-status proc))
	    (unwind-protect
		(if (with-current-buffer source (eq proc rust--flymake-proc))
		    (with-current-buffer (process-buffer proc)
		      (goto-char (point-min))
		      (cl-loop
		       while (search-forward-regexp
			      "^\\(\\warning\\|error\\):[[:blank:]]\\([[:print:]]+\\)[[:cntrl:]]+[[:blank:]]+[[:print:]]+[[:blank:]]+\\([[:print:]]+.rs\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\)$"
			      nil t)
		       ;; TODO: Do more regex search to format the error message
		       for msg = (match-string 2)
		       for msg-type = (match-string 1)
		       for (beg . end) = (flymake-diag-region
					  source
					  (string-to-number (match-string 4)))
		       for type = (if (string-match "warning" msg-type)
				      :warning
				    :error)
		       collect (flymake-make-diagnostic source
							beg
							end
							type
							msg)
		       into diags
		       finally (funcall report-fn diags)))
		  (flymake-log :warning "Cancelling obsolete check %s" proc))
	      (kill-buffer (process-buffer proc)))))))
      (process-send-eof rust--flymake-proc))))

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :config
  :hook (rust-mode . (lambda ()
		       (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
		       (add-hook 'flymake-diagnostic-functions 'rust-flymake-backend))))

(use-package ob-rust
  :ensure t
  :requires rust-mode
  :after org
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
			       (append org-babel-load-languages
				       '((rust . t)))))

(provide 'config-rust)
