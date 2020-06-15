(use-package debbugs
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package exec-path-from-shell
  :demand t
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(defvar-local mine/webcam-process nil)
(defun mine/toggle-webcam ()
  (interactive)
  (if (= nil mine/webcam-process)
      (kill-process mine/webcam-process)
    (start-process "ffplay" nil "ffplay" "/dev/video0")))
  

(provide 'config-misc)
