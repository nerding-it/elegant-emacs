(use-package newsticker
  :custom
  (newsticker-url-list-defaults nil)
  (newsticker-retrieval-interval 0)
  (newsticker-automatically-mark-items-as-old nil)
  (newsticker-frontend 'newsticker-treeview)
  (newsticker-dir (expand-file-name "news/" mine-cache-directory))
  (newsticker-url-list '(
			 ("reddit-emacs" "https://www.reddit.com/r/emacs.rss" nil nil nil)
			 ("reddit-memes" "https://www.reddit.com/r/memes.rss" nil nil nil)
			 ("twitter-emacs" "https://twitrss.me/twitter_user_to_rss/?user=emacs" nil nil nil)
			 ("reddit-unixporn" "https://www.reddit.com/r/unixporn.rss" nil nil nil))))
(provide 'config-newsticker)

(provide 'config-newsticker)
