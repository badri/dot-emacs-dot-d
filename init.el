
(add-to-list 'load-path "~/.emacs.d")

; some GUI cleanups
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(require 'ido)
(ido-mode t)
(require 'python)
(load-library "badri-python")


(load-library "badri-visual-nicities")
(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))

; Steve Yegge'e js2 mode.
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(load-library "js2")

(require 'pager)

;; toggle line numbers using "M-x ln"
(require 'linum)

;; to visualize tabs
(require 'blank-mode)

;; git mode
(add-to-list 'load-path "~/.emacs.d/git-emacs")
(load-library "git-emacs")

;; xml mode
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


;; org mode
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
(defalias 'ir 'indent-region)
(defalias 'sh 'show-entry)
(defalias 'he 'hide-entry)
(defalias 'gl 'goto-line) 

(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;; window frame title
(setq frame-title-format "emacs [%b %*%+ %f]")
(setq icon-title-format "emacs [%b]")

;; backward kill word.
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

; C-x rji will open init.el 
(set-register ?i '(file . "~/.emacs.d/init.el"))
