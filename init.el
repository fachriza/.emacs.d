(add-to-list 'load-path "~/.emacs.d/")

(require 'ido)
(ido-mode t)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(show-paren-mode t)
(setq backup-inhibited t)
(setq auto-save-default nil)
(global-font-lock-mode t)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(require 'melpa)
(require 'popup)

;;Themes
(load-theme 'wombat t)
