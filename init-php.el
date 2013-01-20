(require 'php-mode)
(require 'flymake)

;; Pear coding standards : http://pear.php.net/manual/en/standards.indenting.php
(defun pear/php-mode-init ()
  "Set some buffer-local variables."
  (setq case-fold-search t)
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (setq c-basic-offset 4)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'case-label 2)
  (c-set-offset 'arglist-close 0))
(add-hook 'php-mode-hook 'pear/php-mode-init)


(defun my-php-hook-function ()
  (set (make-local-variable 'compile-command) (format "php_lint %s" (buffer-file-name))))
(add-hook 'php-mode-hook 'my-php-hook-function)

(add-to-list 'flymake-allowed-file-name-masks '("\.php$" flymake-php-init))
(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))

(provide 'init-php)