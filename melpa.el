(require 'cl)
(require 'package)

;;add the repository
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(setq url-http-attempt-keepalives nil)

;;There is a small bug in Emacs24’s package.el 
;;the order for dependencies comes out backwards for what I needed. 
;;the problem is patched by some advice.
(defadvice package-compute-transaction
  (before
   package-compute-transaction-reverse (package-list requirements)
   activate compile)
  "reverse the requirements"
  (setq requirements (reverse requirements))
  (print requirements))

(defvar packages 
  '(
    auto-complete
    expand-region
    flymake-cursor
    ido-ubiquitous
    magit
    wrap-region
    ;; paredit
    ;; clojure-mode
    ecb
    js3-mode
    ;;flymake-jslint
    ;;flymake-php
    flymake-css 
    flymake-json
))

(defun fully-installed-p ()
  (loop for p in packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(defun get-packages ()
  (unless (fully-installed-p)
    (package-refresh-contents)
    (dolist (p packages)
      (unless (package-installed-p p)
        (package-install p)))))

(get-packages)

(when (package-installed-p 'auto-complete)
  (require 'auto-complete-config)
  (ac-config-default))

(when (package-installed-p 'flymake-cursor)
  (require 'flymake-cursor))  

(when (package-installed-p 'ido-ubiquitous)
  (require 'ido-ubiquitous)
  (ido-ubiquitous-mode t))

;; (when (package-installed-p 'paredit)
;;   (require 'paredit))

;; (when (package-installed-p 'clojure-mode)
;;   (require 'clojure-mode))
;;   (add-hook 'clojure-mode-hook 'paredit-mode)

(when (package-installed-p 'js3-mode)
  (require 'js3-mode))

;; (when (package-installed-p 'yasnippet)
;;   (require 'yasnippet))
;;   (yas--initialize)
;;   (yas/load-directory "~/.emacs.d/elpa/yasnippet-20130112.1823/snippets")

(when (package-installed-p 'ecb)
  (require 'ecb))
  (setq stack-trace-on-error t)

;; (when (package-installed-p 'flymake-jslint)
;;   (require 'flymake-jslint))

;; (when (package-installed-p 'flymake-php)
;;   (require 'flymake-php))

(when (package-installed-p 'flymake-css)
  (require 'flymake-css))

(when (package-installed-p 'flymake-json)
  (require 'flymake-json))


(provide 'melpa)
