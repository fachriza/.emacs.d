(require 'cl)
(require 'package)

;;add the repository
(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)
(setq url-http-attempt-keepalives nil)


(defvar prelude-packages
  '(
    auto-complete 
    expand-region 
    flymake-cursor
    ido-ubiquitous 
    magit wrap-region 
    ecb 
    js2-mode
    yasnippet-bundle 
    dropdown-list
    php-mode
    php-extras
    flymake
    flymake-easy
    flymake-jslint
    flymake-php
    flymake-css
    fill-column-indicator
    )
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(when (package-installed-p 'auto-complete)
  (require 'auto-complete-config)
  (ac-config-default))

(when (package-installed-p 'flymake-cursor)
  (require 'flymake-cursor))  

(when (package-installed-p 'ido-ubiquitous)
  (require 'ido-ubiquitous)
  (ido-ubiquitous-mode t))

;; (when (package-installed-p 'php-mode)
;;   (require 'php-mode)

(when (package-installed-p 'js3-mode)
  (require 'js3-mode))

(when (package-installed-p 'ecb)
  (require 'ecb))
  (setq stack-trace-on-error t)

;;marmalade
(when (package-installed-p 'yasnippet-bundle)
  (require 'yasnippet-bundle))
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/elpa/yasnippet-bundle-0.6.1")

(when (package-installed-p 'dropdown-list)
  (require 'dropdown-list))
  (setq yas/prompt-functions 
        '(yas/dropdown-prompt yas/ido-prompt yas/completing-prompt))

(when (package-installed-p 'flymake)
  (require 'flymake))

(when (package-installed-p 'flymake-easy)
  (require 'flymake-easy))

(when (package-installed-p 'flymake-php)
  (require 'flymake-php))

(when (package-installed-p 'flymake-css)
  (require 'flymake-css))

(when (package-installed-p 'fill-column-indicator)
  (require 'fill-column-indicator))
    (setq whitespace-style '(face trailing))

(provide 'prelude-packages)
