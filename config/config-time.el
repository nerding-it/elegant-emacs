(use-package time
  :custom
  (display-time-24hr-format t)
  (display-time-use-mail-icon t)
  (display-time-day-and-date nil)
  (display-time-world-list '(("Asia/Calcutta" "Bengaluru")
			     ("America/New_York" "New York")
			     ("America/Los_Angeles" "Seatle")))
  :config
  (display-time-mode))

(provide 'config-time)
