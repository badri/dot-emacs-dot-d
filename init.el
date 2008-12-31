(add-to-list 'load-path "~/.emacs.d")

; some GUI cleanups
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(require 'ido)
(ido-mode t)
(require 'python)
(load-library "badri-python")
(load-library "arc")

; blogging @ my wp ac.
(require 'weblogger)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blank-chars (quote (tabs lines space-before-tab)))
 '(weblogger-config-alist (quote (("default" ("user" . "badrix") ("server-url" . "http://badrix.wordpress.com/xmlrpc.php") ("weblog" . "4167400"))))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
; spell check on blog
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(require 'textile-minor-mode)

(add-hook 'weblogger-entry-mode-hook 'textile-minor-mode)
(add-hook 'weblogger-entry-mode-hook 'flyspell-mode)

(defun publish-post ()
  (interactive)
  (textile-to-html-buffer-respect-weblogger)
  (weblogger-publish-entry)
 )
(global-set-key "\C-cbs" 'weblogger-start-entry)
(cua-mode t)
(load-library "badri-visual-nicities")
(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))

; Steve Yegge'e js2 mode.
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(load-library "js2")

; arc stuff.
(add-to-list 'auto-mode-alist '("\\.arc$" . arc-mode))

(require 'pager)

; toggle line numbers using "M-x ln"
(require 'linum)

; to visualize tabs
(require 'blank-mode)

; git mode
(add-to-list 'load-path "~/.emacs.d/git-emacs")
(load-library "git-emacs")

(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ln 'linum)
(defalias 'cor 'comment-region)
(defalias 'bm 'blank-mode)
(defalias 'cr 'comment-region)
 

(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)