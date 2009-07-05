
(add-to-list 'load-path "~/.emacs.d")

; some GUI cleanups
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(require 'ido)
(ido-mode t)
(require 'python)
;;(load-library "badri-python")
(load-library "arc")



(cua-mode t)
(load-library "badri-visual-nicities")
(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))

; Steve Yegge'e js2 mode.
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(load-library "js2")


(require 'pager)

; toggle line numbers using "M-x ln"
(require 'linum)

; to visualize tabs
(require 'blank-mode)


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

; backward kill word.
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

; C-x rji will open init.el 
(set-register ?i '(file . "~/.emacs.d/init.el"))
