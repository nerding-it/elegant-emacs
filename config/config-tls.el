(use-package gnutls
  :demand t
  :custom
  (gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(provide 'config-tls)
