(use-package vc-hooks
  :config
  ;; TODO: Need to do same for ‘vc-dired’
  (define-key vc-prefix-map "=" 'vc-ediff))
  
(provide 'config-vc)
