(use-package newsticker
  :custom
  (newsticker-url-list-defaults nil)
  (newsticker-retrieval-interval 0)
  (newsticker-automatically-mark-items-as-old nil)
  (newsticker-frontend 'newsticker-treeview)
  (newsticker-dir (expand-file-name "news/" mine-cache-directory)))
(provide 'config-newsticker)
