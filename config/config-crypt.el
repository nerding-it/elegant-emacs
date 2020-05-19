(use-package epa
  :after emacs
  :custom
  (epa-file-encrypt-to user-mail-address)
  (epa-pinentry-mode 'loopback)
  (epa-file-select-keys nil))

(use-package org-crypt
  :after (org epa)
  :custom
  (org-crypt-key epa-file-encrypt-to))

(provide 'config-crypt)
