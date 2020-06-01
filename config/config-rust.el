(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :config
  (add-to-list 'flymake-proc-allowed-file-name-masks
	       '(".+\\.rs$"
		 (lambda () '("cargo" ("check")))
		 flymake-proc-simple-cleanup
		 flymake-proc-get-real-file-name))

  (add-to-list 'flymake-proc-err-line-patterns
	       '("^\\(.*\\)[\n] --> \\(.*.rs\\):\\([0-9]+\\):\\([0-9]+\\)$"
		 2 3 4 1))
  (remove-hook 'flymake-diagnostic-backend 'flymake-proc-legacy-flymake)
  :hook (rust-mode . flymake-mode))

(use-package ob-rust
  :ensure t
  :requires rust-mode
  :after org
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
			       (append org-babel-load-languages
				       '((rust . t)))))

(provide 'config-rust)
