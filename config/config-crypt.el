(use-package epa
  :custom
  (epa-file-encrypt-to user-mail-address)
  (epa-pinentry-mode 'loopback)
  (epa-file-select-keys nil))

(use-package org-crypt
  :after org)

(provide 'config-crypt)
