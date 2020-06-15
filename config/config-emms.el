(use-package emms
  :ensure t
  :config
  (require 'emms-setup)
  (require 'emms-player-simple)
  (require 'emms-streams)
  (require 'emms-librefm-stream)
  (require 'emms-player-mplayer)
  (require 'emms-source-file)
  (require 'emms-source-playlist)
  (emms-standard)
  (emms-default-players)
  :custom
  (emms-playlist-buffer-name "*Music*")
  (emms-player-list '(emms-player-mplayer emms-player-ogg123 emms-player-mpg321)))
  
(provide 'config-emms)
