(when (eq mine-window-manager t)

  (defun exwm/setup-keys ()
    (exwm-input-set-key (kbd "s-r") 'exwm/start-program)
    (exwm-input-set-key (kbd "s-R") 'exwm-reset)
    (exwm-input-set-key (kbd "s-w") 'exwm-workspace-switch)
    (exwm-input-set-key (kbd "s-h") 'windmove-left)
    (exwm-input-set-key (kbd "s-l") 'windmove-right)
    (exwm-input-set-key (kbd "s-j") 'windmove-up)
    (exwm-input-set-key (kbd "s-k") 'windmove-down)
    (exwm-input-set-key (kbd "s-b") 'ibuffer-list-buffers)
    (exwm-input-set-key (kbd "s-f") 'find-file)
    (exwm-input-set-key (kbd "s-D") 'kill-this-buffer)
    (exwm-input-set-key (kbd "s-O") 'exwm-layout-toggle-fullscreen)
    (exwm-input-set-key (kbd "s-a") 'async-shell-command)
    (exwm-input-set-key (kbd "s-z") 'exwm/lock-screen)
    (exwm-input-set-key (kbd "s-q") 'exwm/suspend)
    (exwm-input-set-key (kbd "s-E") 'eww)
    (exwm-input-set-key (kbd "s-c") 'calendar)
    (exwm-input-set-key (kbd "s-t") 'display-time-world))
  
  (defun exwm/setup-output-devices ()
    ;; This sets displaylink monitor to output, since hotplug is not supported
    (let ((xrandr-output-regexp "Provider \\([0-9]\\)"))
      (with-temp-buffer
	(call-process "xrandr" nil t nil "--listproviders")
	(goto-char (point-min))
	(while (re-search-forward xrandr-output-regexp nil 'noerror)
	  (if (> (string-to-number (match-string 1)) 0)
	      (call-process
	       "xrandr" nil nil nil
	       "--setprovideroutputsource" (match-string 1) "0")))))
    ;; This sets connected monitor to workspace plist
    (let ((xrandr-output-regexp "\n\\([^ ]+\\) connected ")
	  output-index
	  output-plist)
      (with-temp-buffer
	(setq output-index 0)
	(setq output-plist ())
	(call-process "xrandr" nil t nil)
	(goto-char (point-min))
	(while (re-search-forward xrandr-output-regexp nil 'noerror)
	  (setq output-plist (plist-put output-plist output-index (match-string 1)))
	  (setq output-index (+ output-index 1)))
	(setq exwm-randr-workspace-monitor-plist output-plist))))

  (defun exwm/start-dropbox-service ()
    "Start dropbox service if it's not running"
    (require 'subr-x)
    (when (executable-find "dropbox")
      (if (string-empty-p (shell-command-to-string "dropbox running"))
	  (start-process-shell-command "dropbox" nil "dropbox start"))))

  (defun exwm/monitor-only-builtin ()
    "Switch to laptop display"
    (interactive)
    (start-process-shell-command
     "xrandr"
     nil
     "xrandr --output eDP-1 --auto --output HDMI-1 --off --output DVI-I-1-1 --off"))

  (defun exwm/monitor-only-main ()
    "Switch to main monitor"
    (interactive)
    (start-process-shell-command
     "xrandr"
     nil
     "xrandr --output eDP-1 --off --output DVI-I-1-1 --off --output HDMI-1 --auto"))

  (defun exwm/monitor-builtin-and-main ()
    "Both laptop and main monitor"
    (interactive)
    (start-process-shell-command
     "xrandr"
     nil
     "xrandr --output DVI-I-1-1 --off --output eDP-1 --left-of HDMI-1 --auto"))

  (defun exwm/monitor-only-secondary ()
    "Use only secondary monitor"
    (interactive)
    (start-process-shell-command
     "xrandr"
     nil
     "xrandr --output eDP-1 --off --output HDMI-1 --off --output DVI-I-1-1 --auto"))

  (defun exwm/monitor-main-and-secondary ()
    "Use main and secondary monitor"
    (interactive)
    (start-process-shell-command
     "xrandr"
     nil
     "xrandr --output eDP-1 --off --output HDMI-1 --left-of DVI-I-1-1 --auto"))

  (defun exwm/monitor-all ()
    "Use all monitors"
    (interactive)
    (start-process-shell-command
     "xrandr"
     nil
     (concat
      "xrandr --output DVI-I-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal "
      "--output eDP-1 --mode 1366x768 --pos 0x1080 --rotate normal "
      "--output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal")))

  (defun exwm/update-title ()
    (when (or (not exwm-instance-name)
	      (string-prefix-p "sun-awt-X11-" exwm-instance-name)
	      (string= "gimp" exwm-instance-name))
      (exwm-workspace-rename-buffer exwm-title)))

  (defun exwm/update-class ()
    (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
		(string= "gimp" exwm-instance-name))
      (exwm-workspace-rename-buffer exwm-class-name)))


  (defun exwm/start-program (command)
    (interactive
     (list (read-shell-command "$ ")))
    (start-process-shell-command command nil command))

  (defun exwm/lock-screen ()
    (interactive)
    (start-process-shell-command "loginctl" nil "loginctl lock-session $XDG_SESSION_ID"))

  (defun exwm/suspend ()
    (interactive)
    (start-process-shell-command "suspend" nil "systemctl suspend"))

  (defun exwm/screen-shot ()
    (interactive)
    (if (executable-find "scrot")
	(start-process-shell-command "scrot" nil "scrot screen-%F-%T.png")
      (message "You need to install scrot to use screenshot feature")))

  (use-package exwm
    :ensure t
    :bind
    (("<XF86Calculator>" . calc)
     ("<XF86Launch5>" . delete-other-windows)
     ("<XF86Launch6>" . split-window-vertically)
     ("<XF86Launch7>" . split-window-horizontally)
     ("<Scroll_Lock>" . scroll-lock-mode)
     ("<XF86Search>"  . occur)
     ("<XF86Mail>"    . gnus)
     ("<XF86Home>"    . ibuffer-list-buffers)
     ("<XF86Favorites>" . bookmark-set)
     ("<XF86Launch8>" . exwm-workspace-move-window)
     ("<XF86Launch9>" . exwm-workspace-switch))
    :custom
    (exwm-workspace-show-all-buffers t)
    (exwm-input-global-keys
     `(
       ([s-R]   . exwm-reset)
       ([s-w]   . exwm-workspace-switch)
       ([s-f1]  . exwm/monitor-only-builtin)
       ([s-f2]  . exwm/monitor-only-main)
       ([s-f3]  . exwm/monitor-builtin-and-main)
       ([s-f4]  . exwm/monitor-main-and-secondary)
       ([s-f5]  . exwm/monitor-only-secondary)
       ([s-f6]  . exwm/monitor-all)
       ([print] . exwm/screen-shot)
       ([home]  . beginning-of-buffer)
       ([end]   . end-of-buffer)
       ([s-tab] . ido-switch-buffer)
       ([?\s-w] . exwm-workspace-switch)
       ,@(mapcar (lambda (i)
                   `(,(kbd (format "s-%d" i)) .
		     (lambda ()
                       (interactive)
                       (exwm-workspace-switch-create ,i))))
		 (number-sequence 0 9))))
    (exwm-workspace-number 3)
    ;; (exwm-workspace-minibuffer-position nil)
    (mouse-autoselect-window t)
    (focus-follows-mouse t)
    :config
    (add-hook 'exwm-floating-setup-hook #'exwm-layout-hide-mode-line)
    (add-hook 'exwm-floating-exit-hook #'exwm-layout-show-mode-line)
    (add-hook 'exwm-init-hook #'exwm/setup-output-devices)
    (add-hook 'exwm-init-hook #'exwm/setup-keys)
    (add-hook 'exwm-init-hook #'exwm/start-dropbox-service)
    (add-hook 'exwm-update-class-hook #'exwm/update-class)
    (add-hook 'exwm-update-title-hook #'exwm/update-title)

    (require 'exwm-randr)
    (exwm-randr-enable)))

(provide 'config-wm)
