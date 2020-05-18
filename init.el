(defgroup mine nil
  "Custom configuration for mine"
  :group 'local)

(defcustom mine-appearance
  'elegant
  "The appearance to use."
  :type '(radio
	  (const :tag "default" default)
	  (const :tag "elegant" poet))
  :group 'mine)

(defcustom mine-cache-directory
  (expand-file-name ".cache/" user-emacs-directory)
  "The storage location for various persistent files."
  :type 'directory
  :group 'mine)

(defcustom mine-second-brain-location
  (expand-file-name "Org/" "~")
  "The location for second brain."
  :type 'directory
  :group 'mine)

(defcustom mine-window-manager
  t
  "Whether emacs should be used as window manager or not."
  :type 'boolean
  :group 'mine)

;; Make sure you already installed `use-package` through package manager
;; In my case I am using debian, I just install with apt-get install elpa-usepackage
(require 'use-package)

(use-package cus-edit  
  :demand t
  :custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :init
  (when (file-exists-p custom-file)
    (load custom-file)))

(let ((config-directory (expand-file-name "config/" user-emacs-directory)))
  (load (expand-file-name "config-core.el" config-directory))
  (load (expand-file-name "config-tls.el" config-directory))
  (load (expand-file-name "config-package.el" config-directory))
  (load (expand-file-name "config-wm.el" config-directory))
  (load (expand-file-name "config-appearance.el" config-directory))
  (load (expand-file-name "config-time.el" config-directory))
  (load (expand-file-name "config-battery.el" config-directory))
  (load (expand-file-name "config-dired.el" config-directory))
  (load (expand-file-name "config-eshell.el" config-directory))
  (load (expand-file-name "config-crypt.el" config-directory))
  (load (expand-file-name "config-desktop.el" config-directory))
  (load (expand-file-name "config-prog.el" config-directory))
  (load (expand-file-name "config-org.el" config-directory))
  (load (expand-file-name "config-emms.el" config-directory))
  (load (expand-file-name "config-buffer.el" config-directory))
  (load (expand-file-name "config-ido.el" config-directory))
  (load (expand-file-name "config-windows.el" config-directory))
  (load (expand-file-name "config-calendar.el" config-directory))
  (load (expand-file-name "config-newsticker.el" config-directory))
  (load (expand-file-name "config-gnus.el" config-directory))
  (load (expand-file-name "config-grammar.el" config-directory))
  (load (expand-file-name "config-web.el" config-directory))             
  (require 'config-core)
  (require 'config-calendar)
  (require 'config-tls)
  (require 'config-package)
  (require 'config-wm)
  (require 'config-appearance)
  (require 'config-time)
  (require 'config-battery)
  (require 'config-dired)
  (require 'config-eshell)
  (require 'config-crypt)
  (require 'config-desktop)
  (require 'config-prog)
  (require 'config-org)
  (require 'config-emms)
  (require 'config-ido)
  (require 'config-buffer)
  (require 'config-windows)
  (require 'config-newsticker)
  (require 'config-gnus)
  (require 'config-grammar)
  (require 'config-web))
