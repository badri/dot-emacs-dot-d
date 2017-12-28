
(when t ;window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(setq user-full-name "Lakshmi Narasimhan"
      user-mail-address "lakshmi@lakshminp.com")

(package-initialize)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))

(load-theme 'birds-of-paradise-plus t)

(cua-mode t)
