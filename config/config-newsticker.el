(use-package newsticker
  :custom
  (newsticker-url-list-defaults nil)
  (newsticker-retrieval-interval 0)
  (newsticker-automatically-mark-items-as-old nil)
  (newsticker-frontend 'newsticker-plainview)
  (newsticker-dir (expand-file-name "news/" mine-cache-directory))
  (newsticker-url-list '(
			 ("reddit-emacs" "https://www.reddit.com/r/emacs.rss" nil nil nil)
			 ("reddit-unixporn" "https://www.reddit.com/r/unixporn.rss" nil nil nil))))

(provide 'config-newsticker)
