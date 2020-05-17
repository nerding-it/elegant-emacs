(use-package emms
  :ensure t
  :config
  (require 'emms-player-simple)
  (require 'emms-source-file)
  :custom
  (emms-player-list '(emms-player-mpg321
		      emms-player-ogg123
		      emms-player-mplayer))
  (emms-playlist-buffer-name "*Music*"))

(provide 'config-emms)
