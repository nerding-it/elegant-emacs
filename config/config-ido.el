
(defun mine/ido-window-register-filter (elem)
  (string-match "\\window[[:blank:]]configuration" (register-describe-oneline (car elem))))

(defun mine/ido-window-register-display-fn (elem)
  (format "%s->%s:%s"
	  (single-key-description (car elem))
	  (register-describe-oneline (car elem))
	  ;; FIXME: It's not required for me, but to extract key from alist it's included in string
	  (car elem)))

(defun mine/ido-window-register-list ()
  (mapcar 'mine/ido-window-register-display-fn (seq-filter 'mine/ido-window-register-filter register-alist)))  
	  
(defun mine/ido-jump-to-window-register (register)
  (interactive (list (ido-completing-read "reg: " (mine/ido-window-register-list))))
  (string-match "\\.*:\\([[:digit:]]+\\)" register)
  (jump-to-register (string-to-number (match-string 1 register))))

(use-package ido
  :demand t
  :bind (("C-x b" . ido-switch-buffer)
	 ("C-x r b" . (lambda (bname)
		      (interactive (list (ido-completing-read "Bookmark: " (bookmark-all-names) nil t)))
		      (bookmark-jump bname))))		      
  :custom
  (ido-decorations
   '("{" "}" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))
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
				       (setq-local max-mini-window-height 10))))

(use-package icomplete
  :custom
  (icomplete-in-buffer t)
  (icomplete-compute-delay .2)
  (icomplete-max-delay-chars 2)
  (icomplete-separator " | ")
  (icomplete-minibuffer-map
   (let ((map (make-sparse-keymap)))
     (define-key map [?\M-\t] 'minibuffer-force-complete)
     (define-key map [?\C-j] 'icomplete-force-complete-and-exit)
     (define-key map [?\C-s] 'icomplete-forward-completions)
     (define-key map [?\C-p] 'icomplete-backward-completions)
     map))
  :config
  (icomplete-mode)
  (completion-in-region-mode)
  :hook (icomplete-minibuffer-setup . (lambda ()
					(setq-local max-mini-window-height 10))))

(use-package ibuffer
  :custom
  (setq ibuffer-saved-filter-groups
   (quote (("default"
	    ("dired" (mode . dired-mode))
	    ("erc" (mode . erc-mode))
	    ("emacs" (or
		      (name . "^\\*scratch\\*$")
		      (name . "^\\*Messages\\*$")))))))
  :config
  (add-hook 'ibuffer-mode-hook (lambda ()
				 (ibuffer-switch-to-saved-filter-groups "default")))
(provide 'config-ido)
