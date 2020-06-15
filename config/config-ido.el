(defun mine/ido-window-register-filter (elem)
  (string-match "\\(window[[:blank:]]configuration\\|buffer[[:blank:]]position\\|keyboard[[:blank:]]macro\\)" (register-describe-oneline (car elem))))

(defun mine/ido-text-register-filter (elem)
  (string-match "\\(rectangle\\|text\\|[[:digit:]]+\\)" (register-describe-oneline (car elem))))

(defun mine/ido-register-display-fn (elem)
  (format "%s->%s:%s"
	  (single-key-description (car elem))
	  (register-describe-oneline (car elem))
	  ;; FIXME: It's not required for me, but to extract key from alist it's included in string
	  (car elem)))

(defun mine/ido-window-register-list ()
  (mapcar 'mine/ido-register-display-fn (seq-filter 'mine/ido-window-register-filter register-alist)))

(defun mine/ido-text-register-list ()
  (mapcar 'mine/ido-register-display-fn (seq-filter 'mine/ido-text-register-filter register-alist)))
	  
(defun mine/ido-jump-to-register (register)
  (interactive (list (ido-completing-read "reg: " (mine/ido-window-register-list))))
  (string-match "\\.*:\\([[:digit:]]+\\)" register)
  (jump-to-register (string-to-number (match-string 1 register))))

(defun mine/ido-insert-text-register (register)
  (interactive (list (ido-completing-read "reg: " (mine/ido-text-register-list))))
  (string-match "\\.*:\\([[:digit:]]+\\)" register)
  (insert-register (string-to-number (match-string 1 register)))) 

(defun mine/ido-jump-to-bookmark (bookmark)
  (interactive (list (ido-completing-read "Bookmark: " (bookmark-all-names) nil t)))
  (bookmark-jump bookmark))

(defun mine/ido-kill-ring (ring) 
  (interactive (list (ido-completing-read "ring: " kill-ring)))
  (insert-for-yank ring))

(use-package ido
  :demand t
  :bind (("C-x b" . ido-switch-buffer)
	 ("C-x r b" . mine/ido-jump-to-bookmark)
	 ("C-x r j" . mine/ido-jump-to-register)
	 ("C-x r i" . mine/ido-insert-text-register)
	 ("C-x y" . mine/ido-kill-ring))
  :custom
  (ido-decorations
   '("{" "}" "\n" " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))
  (ido-enable-prefix nil)
  (ido-file-extensions-order
   '(".org" ".md" ".py" ".el" ".ts" ".js" ".html" ".scss" ".css"))
  (ido-use-virtual-buffers t)
  (ido-enable-flex-matching t)
  (ido-create-new-buffer 'always)
  (ido-save-directory-list-file (expand-file-name "ido.last" mine-cache-directory))
  :config
  (ido-everywhere t)  
  (ido-mode 1)
  :hook (ido-minibuffer-setup-hook . (lambda ()
				       (setq-local max-mini-window-height 50))))

(use-package icomplete
  :demand t
  :hook ((icomplete-minibuffer-setup . (lambda ()
					 (setq-local max-mini-window-height 50))))
  :bind (:map icomplete-minibuffer-map
		("M-TAB" . icomplete-force-complete)
		("C-s" . icomplete-forward-completions)
		("C-p" . icomplete-backward-completions)
		("C-j" . icomplete-force-complete-and-exit))
  :custom
  (icomplete-in-buffer t)
  (icomplete-delay-completions-threshold 0)
  (icomplete-compute-delay 0)
  (icomplete-max-delay-chars 0)
  (icomplete-show-matches-on-no-input t)
  (icomplete-hide-common-prefix nil)  
  (icomplete-separator "\n")
  (global-set-key (kbd "M-/") 'completion-at-point)
  :config
  (icomplete-mode))


  ;; TODO: Need to check for error 
  ;; (completion-in-region-mode)

;; TODO: Need to group like gnus
(use-package ibuffer
  :config
  (setq ibuffer-saved-filter-groups
   (quote (("home"
	    ("dired" (mode . dired-mode))
	    ("erc" (mode . erc-mode))
	    ("emacs" (or
		      (name . "^\\*scratch\\*$")
		      (name . "^\\*Messages\\*$")))
	    ("emacs-lisp" (or
			   (name . "\\.*.el$")))
	    
	    ("gnus" (or
		     (mode . message-mode)
                     (mode . bbdb-mode)
                     (mode . mail-mode)
                     (mode . gnus-group-mode)
                     (mode . gnus-summary-mode)
                     (mode . gnus-article-mode)
                     (name . "^\\.bbdb$")
		     (name . "^\\*Server\\*$")
		     (name . "^\\*Gnus[[:print:]]\\*$")
                     (name . "^\\.newsrc-dribble")))
	    ("vc" (or
		   (name . "*vc*")))
	    ("flymake" (or
			(name . "^\\*Flymake[[:blank:]][[:print:]]\\*$")))
	    ("org" (mode . org-mode))
	    ("help" (or
		     (name . "^\\*Help\\*$")
		     (name . "^\\*info\\*$")
		     (name . "[[:print:]]+\\.el.gz")))
	    ("log" (or
		    (name . "^\\*Backtrace\\*$")
		    (name . "^\\*Completions\\*$")
		    (name . "^\\*Warnings\\*$")))))))
  (add-hook 'ibuffer-mode-hook (lambda ()
				 (ibuffer-auto-mode 1)
				 (ibuffer-switch-to-saved-filter-groups "home"))))
(provide 'config-ido)
