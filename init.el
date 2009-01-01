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

; xml mode
;path to where nxml is
(set 'nxml-path "~/.emacs.d/nxml-mode/")
(load (concat nxml-path "rng-auto.el"))
 (add-to-list 'auto-mode-alist
              (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
                    'nxml-mode))
  (unify-8859-on-decoding-mode)

    (setq magic-mode-alist
	  (cons '("<＼＼?xml " . nxml-mode)
	  magic-mode-alist))
   (fset 'xml-mode 'nxml-mode)


; org mode
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
 (require 'org-install)
 (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
 (define-key global-map "\C-cl" 'org-store-link)
 (define-key global-map "\C-ca" 'org-agenda)
 (setq org-log-done t)



(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ln 'linum)
(defalias 'bm 'blank-mode)
(defalias 'cr 'comment-region)
(defalias 'xa 'nxml-complete) 

(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;; window frame title
(setq frame-title-format "emacs [%b %*%+ %f]")
(setq icon-title-format "emacs [%b]")

; backward kill word.
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
