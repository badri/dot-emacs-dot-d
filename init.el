(add-to-list 'load-path "~/.emacs.d")

; some GUI cleanups
(require 'ido)
(setq
 ido-create-new-buffer    'always
 ido-enable-flex-matching t
 ido-everywhere           t)

(ido-mode t)
(menu-bar-mode -1)




(cua-mode t)
;;(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))

; Steve Yegge'e js2 mode.
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(load-library "js2")

;; (load-file "~/.emacs.d/cedet-1.1/common/cedet.el")

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
(defalias 'wc 'whitespace-cleanup)
(defalias 'cc 'drupal-drush-cache-clear)

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


;; ;; haskell
;;(load "~/.emacs.d/haskell-mode-2.4/haskell-site-file")
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)


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

;; 
;; (global-auto-complete-mode t)

;; (define-key ac-complete-mode-map "\C-n" 'ac-next)
;; (define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; (setq ac-auto-start nil)
;; (global-set-key "\M-/" 'ac-start)
;; (define-key ac-complete-mode-map "\M-/" 'ac-stop)

;; (define-key ac-complete-mode-map "\t" 'ac-complete)
;; (define-key ac-complete-mode-map "\r" nil)

(load-file "~/.emacs.d/find-file-in-tags.el")
(global-set-key (read-kbd-macro "C-,") 'find-file-in-tags)

;; (setq drupal-ide-load-path (concat user-emacs-directory "drupal/drupal-init.el"))
;; (autoload 'drupal-ide drupal-ide-load-path "Start IDE for PHP & Drupal development" t)
;; (load (concat user-emacs-directory "drupal/drupal-init.el"))

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

;; feature mode
;; (require 'feature-mode)
;; (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

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

;; interactive wordcount
(load-file "~/.emacs.d/wordcount-mode.el")

;; inplace annotations
(load-file "~/.emacs.d/ipa.el")

;; ----------------------------------------------------------------

;; scala
(add-to-list 'load-path "~/.emacs.d/scala-mode2/")
(require 'scala-mode2)


;; drupal yasnippet mode
;; (load-file "~/.emacs.d/yasnippet/yasnippet.el")
;; (require 'yasnippet)

;; (setq yas-snippet-dirs
;;       '("~/.emacs.d/drupal-yasnippet"            ;; drupal snippets
;; 	"~/.emacs.d/cucumber.el/snippets"
;;         ))

;; (yas-global-mode 1)

;; magit
(add-to-list 'load-path "~/.emacs.d/git-modes")
(add-to-list 'load-path "~/.emacs.d/magit")
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list "~/.emacs.d/magit/")))
(require 'magit)
(global-set-key (kbd "\C-c\C-g") 'magit-status)

;; code folding
(add-hook 'php-mode-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)


(add-to-list 'load-path "~/.emacs.d/scss-mode")
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-compile-at-save nil)

;; marmalade
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
;; NOTE if package install fails run M-x package-refresh-contents

;; emmet mode

;; solarized theme
(load-theme 'birds-of-paradise-plus t)

;; zenburn theme
;; (load-theme 'zenburn t)


(setq calendar-location-name "Chennai, India") 
(setq calendar-latitude 12.99)
(setq calendar-longitude 80.2)

;; (require 'theme-changer)
;; (change-theme 'solarized-light 'zenburn)

;; naked emacs setup
;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
(setq inhibit-startup-echo-area-message "guerry")
;; This is bound to f11 in Emacs 24.4
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))
;; (toggle-fullscreen)
;; Who use the bar to scroll?
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
;;(set-default-font "Droid Sans Mono-12")
;;(set-default-font "Menlo for Powerline-16")
(set-default-font "Space Mono-16")

;; org mode hacks
 (setq org-todo-keywords
       '((sequence "TODO" "CURRENT" "|" "DONE")))

(defun org-my-custom-timestamp ()
  (interactive)
  (insert (format-time-string "%I:%M %p")))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-ct" 'org-my-custom-timestamp)))

(defun org-my-custom-datestamp ()
  (interactive)
  (insert (format-time-string "%e %b %a")))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-cd" 'org-my-custom-datestamp)))

(defun org-word-count (beg end
                           &optional count-latex-macro-args?
                           count-footnotes?)
  "Report the number of words in the Org mode buffer or selected region.
Ignores:
- comments
- tables
- source code blocks (#+BEGIN_SRC ... #+END_SRC, and inline blocks)
- hyperlinks (but does count words in hyperlink descriptions)
- tags, priorities, and TODO keywords in headers
- sections tagged as 'not for export'.

The text of footnote definitions is ignored, unless the optional argument
COUNT-FOOTNOTES? is non-nil.

If the optional argument COUNT-LATEX-MACRO-ARGS? is non-nil, the word count
includes LaTeX macro arguments (the material between {curly braces}).
Otherwise, and by default, every LaTeX macro counts as 1 word regardless
of its arguments."
  (interactive "r")
  (unless mark-active
    (setf beg (point-min)
          end (point-max)))
  (let ((wc 0)
        (latex-macro-regexp "\\\\[A-Za-z]+\\(\\[[^]]*\\]\\|\\){\\([^}]*\\)}"))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond
         ;; Ignore comments.
         ((or (org-in-commented-line) (org-at-table-p))
          nil)
         ;; Ignore hyperlinks. But if link has a description, count
         ;; the words within the description.
         ((looking-at org-bracket-link-analytic-regexp)
          (when (match-string-no-properties 5)
            (let ((desc (match-string-no-properties 5)))
              (save-match-data
                (incf wc (length (remove "" (org-split-string
                                             desc "\\W")))))))
          (goto-char (match-end 0)))
         ((looking-at org-any-link-re)
          (goto-char (match-end 0)))
         ;; Ignore inline source blocks, counting them as 1 word.
         ((save-excursion
            (backward-char)
            (looking-at org-babel-inline-src-block-regexp))
          (goto-char (match-end 0))
          (setf wc (+ 2 wc)))
         ;; Count latex macros as 1 word, ignoring their arguments.
         ((save-excursion
            (backward-char)
            (looking-at latex-macro-regexp))
          (goto-char (if count-latex-macro-args?
                         (match-beginning 2)
                       (match-end 0)))
          (setf wc (+ 2 wc)))
         ;; Ignore footnotes.
         ((and (not count-footnotes?)
               (or (org-footnote-at-definition-p)
                   (org-footnote-at-reference-p)))
          nil)
         (t
          (let ((contexts (org-context)))
            (cond
             ;; Ignore tags and TODO keywords, etc.
             ((or (assoc :todo-keyword contexts)
                  (assoc :priority contexts)
                  (assoc :keyword contexts)
                  (assoc :checkbox contexts))
              nil)
             ;; Ignore sections marked with tags that are
             ;; excluded from export.
             ((assoc :tags contexts)
              (if (intersection (org-get-tags-at) org-export-exclude-tags
                                :test 'equal)
                  (org-forward-same-level 1)
                nil))
             (t
              (incf wc))))))
        (re-search-forward "\\w+\\W*")))
    (message (format "%d words in %s." wc
                     (if mark-active "region" "buffer")))))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-c," 'org-word-count)))

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun merge-links (new-file)
(interactive (list (read-file-name "Output filename:")) )
(when (eq major-mode 'org-mode)
(goto-char (point-min))
(while (re-search-forward org-bracket-link-analytic-regexp nil t)
(let ( (link-type (match-string 2)) (path (match-string 3)) )
  (if (string= link-type "file") (append-to-file (get-string-from-file path) nil new-file) )
))
(find-file new-file)
))

;; for puppet
(require 'align)

;; IRC
(require 'erc)

;; fringe mode
;; A small minor mode to use a big fringe
(defvar bzg-big-fringe-mode nil)
(define-minor-mode bzg-big-fringe-mode
  "Minor mode to use big fringe in the current buffer."
  :init-value nil
  :global t
  :variable bzg-big-fringe-mode
  :group 'editing-basics
  (if (not bzg-big-fringe-mode)
      (set-fringe-style nil)
    (set-fringe-mode
     (/ (- (frame-pixel-width)
           (* 100 (frame-char-width)))
        2))))

;; Now activate this global minor mode
;; (bzg-big-fringe-mode 1)

;; To activate the fringe by default and deactivate it when windows
;; are split vertically, uncomment this:
;; (add-hook 'window-configuration-change-hook
;;           (lambda ()
;;             (if (delq nil
;;                       (let ((fw (frame-width)))
;;                         (mapcar (lambda(w) (< (window-width w) fw))
;;                                 (window-list))))
;;                 (bzg-big-fringe-mode 0)
;;               (bzg-big-fringe-mode 1))))

;; Use a minimal cursor
;; (setq default-cursor-type 'hbar)

;; Get rid of the indicators in the fringe
;; (mapcar (lambda(fb) (set-fringe-bitmap-face fb 'org-hide))
;;         fringe-bitmaps)

;; yaml
(require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; .raml files also use YAML mode.
(add-to-list 'auto-mode-alist '("\\.raml\\'" . yaml-mode))


;; open plan file
(set-register ?p (cons 'file "~/Dropbox/plan.org"))

;; open d8 file
(set-register ?d (cons 'file "~/Dropbox/drupal/d8.org"))

;; open todo file
(set-register ?t (cons 'file "~/Dropbox/drupal/todo.org"))

;; open haskell cookbook file
(set-register ?h (cons 'file "~/Dropbox/haskell/haskell-cookbook.org"))

;; open haskell cookbook file
(set-register ?u (cons 'file "~/Dropbox/paas/tsuru.txt"))

;; open scriber
(set-register ?s (cons 'file "~/Dropbox/scriber/scriber.org"))

;; manage blog posts
(set-register ?b (cons 'file "~/Dropbox/blog-posts/blogs.org"))


;; org reveal
(require 'ox-reveal)

;; org leanpub
(require 'ox-leanpub)

;; org github
(require 'ox-gfm)

;; org twitter bootstrap
(require 'ox-twbs)


;; org evernote
(load-file "~/.emacs.d/evernote-mode/evernote-mode.el")
(setq evernote-ruby-command "/home/lakshmi/.rvm/rubies/ruby-2.1.2/bin/ruby")
(require 'evernote-mode)


;; new scratch buffer
(defun new-scratch ()
  "open up a guaranteed new scratch buffer"
  (interactive)
  (switch-to-buffer (loop for num from 0
                          for name = (format "blah-%03i" num)
                          while (get-buffer name)
                          finally return name)))

;; 80 lines
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

;; (add-hook 'prog-mode-hook 'whitespace-mode)

;; helm
(require 'helm-config)

;; org-trello
(require 'org-trello)

;; org add source block
;; source: http://wenshanren.org/?p=334
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))

;; elm-mode
(add-to-list 'load-path "~/.emacs.d/elm-mode")
(require 'elm-mode)
(setq elm-compile-command "/home/lakshmi/npm-global/bin/elm-make")
(setq elm-compile-arguments '("--yes" "--warn"))

(defun point-in-comment ()
  (let ((syn (syntax-ppss)))
    (and (nth 8 syn)
         (not (nth 3 syn)))))

(defun my-capitalize-all-pg-keywords ()
  (interactive)
  (require 'sql)
  (save-excursion
    (dolist (keywords sql-mode-postgres-font-lock-keywords) 
      (goto-char (point-min))
      (while (re-search-forward (car keywords) nil t)
        (unless (point-in-comment)
          (goto-char (match-beginning 0))
          (upcase-word 1))))))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

(setq dired-dwim-target t)


(add-hook 'sql-mode-hook
          (lambda ()
            (sql-highlight-postgres-keywords)))

;; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(setq utf-translate-cjk-mode nil)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-ellipsis " ☰")
(setq org-src-fontify-natively t)


(defun lp-export ()
  "Export buffer to a Leanpub book."
  (interactive)
  (if (file-exists-p "./Book.txt")
  (delete-file "./Book.txt"))
  (if (file-exists-p "./Sample.txt")
  (delete-file "./Sample.txt"))
  (org-map-entries
   (lambda ()
     (let* ((level (nth 1 (org-heading-components)))
	    (tags (org-get-tags))
           (title (or (nth 4 (org-heading-components)) ""))
	   (book-slug (org-entry-get (point) "TITLE"))
           (filename
	    (or (org-entry-get (point) "EXPORT_FILE_NAME") (concat (replace-regexp-in-string " " "-" (downcase title)) ".md"))))
       (when (= level 1)
	 ;; add to Sample book if "sample" tag is found.
	 (when (or (member "sample" tags) (string-prefix-p "frontmatter" filename) (string-prefix-p "mainmatter" filename))
	   (append-to-file (concat filename "\n\n") nil "./Sample.txt"))
         (append-to-file (concat filename "\n\n") nil "./Book.txt")
	 ;; set filename only if the property is missing
         (or (org-entry-get (point) "EXPORT_FILE_NAME")  (org-entry-put (point) "EXPORT_FILE_NAME" filename))
         (org-leanpub-export-to-markdown nil 1 nil)))) "-noexport") (org-save-all-org-buffers)
   nil nil)

;;  (shell-command (format "sed -i '1s/^/%s\n/' %s" filename filename))

(add-to-list 'load-path "~/.emacs.d/restclient.el")
(require 'restclient)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((restclient . t)))

(setq org-agenda-files
      (delq nil
            (mapcar (lambda (x) (and (file-exists-p x) x))
                    (append '("~/org/ideas.org"
                      "~/org/habit.org"
                      ;;"~/org/office.org"
                      "~/org/capture.org"
                      "~/org/learn.org"
                      "~/org/blog/blogs.org"
                      "~/org/personal.org"
                      "~/org/mkting.org"
                      "~/org/cp.org"
                      "~/org/todo.org"
                      ;;"~/Dropbox/drupal/d8.org"
                      "~/d8book/easybook/doc/drupal-8-module-development/Contents/nd8.org"
                      ;;"~/org/websites.org"
		      ) (file-expand-wildcards "~/org/projects/*.org")))))
(setq org-agenda-span 2)
(setq org-agenda-tags-column -100) ; take advantage of the screen width
(setq org-agenda-sticky nil)
(setq org-agenda-inhibit-startup t)
(setq org-agenda-use-tag-inheritance t)
(setq org-agenda-show-log t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
(setq org-agenda-time-grid
      '((daily today require-timed)
       "----------------"
       (800 1000 1200 1400 1600 1800)))
(setq org-columns-default-format "%14SCHEDULED %Effort{:} %1PRIORITY %TODO %50ITEM %TAGS")

(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/Dropbox/org/capture.org")

(add-hook 'org-mode-hook
          (lambda () (setq-local make-backup-files nil)))
(org-agenda-list)

(defun org-make-list (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert "- ")
      (forward-line))
    (beginning-of-line)))

(defun org-make-olist (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert (concat (number-to-string (1+ i)) ". "))
      (forward-line))
    (beginning-of-line)))

(defun org-make-checkbox (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert "- [ ] ")
      (forward-line))
    (beginning-of-line)))

(require 'request)

(defun lp-preview ()
  "Generate a preview of your book @ Leanpub."
  (interactive)
  (request
   "https://leanpub.com/drupal8book/preview.json"
   :type "POST"
   :data '(("api_key" . "mZ-X3orkm9zpNizYOEFnHw"))
   :parser 'json-read
   :success (function*
	     (lambda (&key data &allow-other-keys)
	       (message "Preview generation queued at leanpub.com."))))
  )

(add-to-list 'load-path "~/.emacs.d/tomatinho")
(require 'tomatinho)
(global-set-key (kbd "<f12>") 'tomatinho)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(package-selected-packages
   (quote
    (neotree org-trello zenburn-theme yaml-mode workgroups2 workgroups theme-changer puppet-mode powerline org-bullets org htmlize helm go-mode feature-mode emmet-mode elm-mode drupal-mode dockerfile-mode color-theme-solarized birds-of-paradise-plus-theme auto-complete)))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'powerline)
(powerline-default-theme)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun find-overlays-specifying (prop pos)
  (let ((overlays (overlays-at pos))
        found)
    (while overlays
      (let ((overlay (car overlays)))
        (if (overlay-get overlay prop)
            (setq found (cons overlay found))))
      (setq overlays (cdr overlays)))
    found))

(defun highlight-or-dehighlight-line ()
  (interactive)
  (if (find-overlays-specifying
       'line-highlight-overlay-marker
       (line-beginning-position))
      (remove-overlays (line-beginning-position) (+ 1 (line-end-position)))
    (let ((overlay-highlight (make-overlay
                              (line-beginning-position)
                              (+ 1 (line-end-position)))))
        (overlay-put overlay-highlight 'face '(:background "#2e8b57"))
        (overlay-put overlay-highlight 'line-highlight-overlay-marker t))))


(global-set-key [f8] 'highlight-or-dehighlight-line)

(defun remove-all-highlight ()
  (interactive)
  (remove-overlays (point-min) (point-max))
  )

(global-set-key [f9] 'remove-all-highlight)

(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq tramp-default-method "ssh")

     (setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/ideas.org" "Idea")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/mkting.org")
	 "* %?\nEntered on %U\n  %i\n  %a")
        ("b" "Blog post" entry (file "~/org/blog/blogs.org")
	 (file "~/org/tpl-blog.txt") :empty-lines-before 1)
      ("c" "Class" entry (file "~/org/blog/blogs.org")
      "* TODO %^{Course}: Week %^{Week} Lecture %^{Number}\n SCHEDULED: %^{Sched}T\n ** TODO prepare for %\\1-%\\2-%\\3")
      ))

(setq debug-on-error t)
