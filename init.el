
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

; named desktop sessions
; taken from http://scottfrazersblog.blogspot.com/2009/12/emacs-named-desktop-sessions.html
(require 'save-desktop)

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


(global-set-key "\M-q" 'ido-kill-buffer)


;; tramp mode
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
(add-to-list 'auto-mode-alist '("\\.test$" . php-mode))

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

(setq drupal-ide-load-path (concat user-emacs-directory "drupal/drupal-init.el"))
(autoload 'drupal-ide drupal-ide-load-path "Start IDE for PHP & Drupal development" t)
(load (concat user-emacs-directory "drupal/drupal-init.el"))

(defun django-shell (&optional argprompt)
  (interactive "P")
  ;; Set the default shell if not already set
  (labels ((read-django-project-dir
	    (prompt dir)
	    (let* ((dir (read-directory-name prompt dir))
		          (manage (expand-file-name (concat dir "manage.py"))))
	        (if (file-exists-p manage)
		          (expand-file-name dir)
		      (progn
			      (message "%s is not a Django project directory" manage)
			            (sleep-for .5)
				          (read-django-project-dir prompt dir))))))
(let* ((dir (read-django-project-dir
	          "project directory: "
		       default-directory))
       (project-name (first
		            (remove-if (lambda (s) (or (string= "src" s) (string= "" s)))
				        (reverse (split-string dir "/")))))
       (buffer-name (format "django-%s" project-name))
       (manage (concat dir "manage.py")))
  (cd dir)
  (if (not (equal (buffer-name) buffer-name))
      (switch-to-buffer-other-window
       (apply 'make-comint buffer-name manage nil '("shell")))
    (apply 'make-comint buffer-name manage nil '("shell")))
  (make-local-variable 'comint-prompt-regexp)
  (setq comint-prompt-regexp (concat py-shell-input-prompt-1-regexp "\\|"
				          py-shell-input-prompt-2-regexp "\\|"
					       "^([Pp]db) "))
  (add-hook 'comint-output-filter-functions
	        'py-comint-output-filter-function)
  ;; pdbtrack

  (add-hook 'comint-output-filter-functions 'py-pdbtrack-track-stack-file)
  (setq py-pdbtrack-do-tracking-p t)
  (set-syntax-table py-mode-syntax-table)
  (use-local-map py-shell-map)
  (run-hooks 'py-shell-hook))))

;; cucumber mode
(add-to-list 'load-path "~/.emacs.d/cucumber.el")
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; markdown
(load-file "~/.emacs.d/markdown-mode/markdown-mode.el")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(defalias 'il 'markdown-insert-link)
(defalias 'ii 'markdown-insert-image)
(defalias 'ic 'markdown-insert-code)
(defalias 'bq 'markdown-insert-blockquote)
(defalias 'ip 'markdown-insert-blockquote)
(defalias 'ib 'markdown-insert-bold)
(defalias 'h1 'markdown-insert-header-atx-1)
(defalias 'h2 'markdown-insert-header-atx-2)
(defalias 'h3 'markdown-insert-header-atx-3)
(defalias 'h4 'markdown-insert-header-atx-4)
(defalias 'h5 'markdown-insert-header-atx-5)
(defalias 'h6 'markdown-insert-header-atx-6)

;; Stuff for writing

;; org mode
(setq load-path (cons "~/.emacs.d/org-mode/lisp" load-path))
(setq load-path (cons "~/.emacs.d/org-mode/contrib/lisp" load-path))
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2(
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; word wrap
(add-hook `text-mode-hook 'turn-on-visual-line-mode)

;; scala
(add-to-list 'load-path "~/.emacs.d/scala-mode2/")
(require 'scala-mode2)


;; drupal yasnippet mode
(load-file "~/.emacs.d/yasnippet/yasnippet.el")
(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/drupal-yasnippet"            ;; drupal snippets
	"~/.emacs.d/cucumber.el/snippets"
        ))

(yas-global-mode 1)

;; magit
(require 'magit)
(global-set-key (kbd "\C-c\C-g") 'magit-status)
