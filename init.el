
(add-to-list 'load-path "~/.emacs.d")

; some GUI cleanups
(require 'ido)
(ido-mode t)
(menu-bar-mode -1)




(cua-mode t)
(load-library "badri-visual-nicities")
;;(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))

; Steve Yegge'e js2 mode.
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(load-library "js2")

(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")

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
(defalias 'ur 'uncomment-region)
(defalias 'xa 'nxml-complete)
(defalias 'ir 'indent-region)
(defalias 'sh 'show-entry)
(defalias 'he 'hide-entry)
(defalias 'gl 'goto-line) 

(require 'ez)
(global-unset-key  (kbd "C-f"))
(global-unset-key  (kbd "C-b"))
(global-unset-key  (kbd "C-n"))

(global-set-key (kbd "C-n") 'af-bookmark-toggle)
(global-set-key (kbd "C-f") 'af-bookmark-cycle-forward)
(global-set-key (kbd "C-b") 'af-bookmark-cycle-reverse)
;; (global-set-key "" 'af-bookmark-clear-all )


(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;; window frame title
(setq frame-title-format "emacs [%b %*%+ %f]")
(setq icon-title-format "emacs [%b]")
;; when running emacs from xterm, mimic the behaviour of frame/icon titles
(when (and (not window-system)
               (string-match "^xterm" (getenv "TERM")))
      (require 'xterm-title)
      (xterm-title-mode 1))

; backward kill word.
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

; C-x rji will open init.el 
(set-register ?i '(file . "~/.emacs.d/init.el"))

(autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
(autoload 'cycle-buffer-backward "cycle-buffer" "Cycle backward." t)
(autoload 'cycle-buffer-permissive "cycle-buffer" "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive "cycle-buffer" "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting "cycle-buffer" "Toggle if this buffer will be considered." t)
(global-set-key "\M-p" 'cycle-buffer-backward)
(global-set-key "\M-n" 'cycle-buffer)
(global-set-key [(shift f9)] 'cycle-buffer-backward-permissive)
(global-set-key [(shift f10)] 'cycle-buffer-permissive)


;; haskell
(load "~/.emacs.d/haskell-mode-2.4/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; git-emacs
;; (add-to-list 'load-path "~/.emacs.d/git-emacs")
;; (require 'git-emacs)

(global-set-key "\M-q" 'ido-kill-buffer)


;; tramp mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/tramp-2.1.16/lisp"))
(require 'tramp)
(setq tramp-default-method "ssh")

;; php related stuff
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
;; Drupal specific
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.profile$" . php-mode))
;; Drupal coding standards
(defun wicked/php-mode-init ()
   "Set some buffer-local variables."
   (setq case-fold-search t) 
   (setq indent-tabs-mode nil)
   (setq fill-column 78)
   (setq c-basic-offset 2)
   (c-set-offset 'arglist-cont 0)
   (c-set-offset 'arglist-intro '+)
   (c-set-offset 'case-label 2)
   (c-set-offset 'arglist-close 0))
 (add-hook 'php-mode-hook 'wicked/php-mode-init)
;; for debugging
(global-ede-mode 1)
;; (semantic-load-enable-code-helpers)
;; (global-srecode-minor-mode 1)
(add-to-list 'load-path "~/.emacs.d/geben-0.26")
(autoload 'geben "geben" "PHP Debugger on Emacs" t)
;; CTags support
(setq path-to-ctags "/usr/bin/ctags") ;; <- your ctags path here
  (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )

(require 'auto-complete)
(global-auto-complete-mode t)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(setq ac-auto-start nil)
(global-set-key "\M-/" 'ac-start)
(define-key ac-complete-mode-map "\M-/" 'ac-stop)

(define-key ac-complete-mode-map "\t" 'ac-complete)
(define-key ac-complete-mode-map "\r" nil)

(load-file "~/.emacs.d/find-file-in-tags.el")
(global-set-key (read-kbd-macro "C-,") 'find-file-in-tags)
