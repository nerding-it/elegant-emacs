(use-package newsticker
  :custom
  (newsticker-url-list-defaults nil)
  (newsticker-dir (expand-file-name "news/" mine-cache-directory))
  (newsticker-url-list '(
			 ("reddit-emacs" "https://www.reddit.com/r/emacs.rss" nil nil nil))))

(provide 'config-newsticker)
