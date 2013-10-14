;;; drupal-mode.el --- major mode for Drupal coding

;; Copyright © 2012 Alexander I.Grafov

;; Author: Alexander I.Grafov <axel@drupal.ru>
;; Version: 1.0-dev
;; Package-Requires: ((flymake "0.3") (php-mode "1.6.0"))
;; Keywords: drupal php languages
;; URL: http://drupal.org/project/emacs

;; This file is not part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License

;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;;

;;; Code:

(require 'php-mode)
(require 'etags)
(require 'flymake)

;;-----------------------------------------------------------------------------
;; Drupal mode
;;
;;;###autoload
(define-derived-mode drupal-mode php-mode "Drupal/PHP" ; RULE#1
  "Major mode for PHP-coding under Drupal Coding Standards.\n\n\\{drupal-mode-map}"
	:group 'drupal
	(setq tab-width 2) ; by Drupal coding standard
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (c-set-offset 'case-label '+)
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values
	(run-mode-hooks 'drupal-mode-hook)
)

;;-----------------------------------------------------------------------------
;; Non interactive helper functions.
;;
(defun drupal-module-name ()
  "Return the Drupal module name for .module and .install files."
  (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))

(defun drupal-hook-template-insert () ; see extras/drupal-insert-hook.el
  "Clone the specified function as a new module hook implementation. Depends on etags/ctags functionality."
	(cond
	 ((not (symbol-at-point)) nil)
	 ((not drupal-ide-use-etags) nil)
   ((let ((modname (drupal-module-name))
					(abbr-end (point))
					(abbr-beginning))
			(drupal-backward-abbrev)
			(setq abbr-beginning (point))
			(find-tag
								(format "^function %s("
												(replace-regexp-in-string "-" "_"
																									(replace-regexp-in-string "^h-" "hook_"
																																						(filter-buffer-substring abbr-beginning abbr-end nil t)))) nil t)
			(let ((tmp-buffer (generate-new-buffer "*temp*")))
				(c-mark-function)
				(copy-to-buffer tmp-buffer (point) (mark))
				(kill-buffer) ;; the relevant API file
				(switch-to-buffer tmp-buffer))
			(newline)
			(forward-line -1)
			(insert "/**\n * Implements ")
			(forward-word)
			(forward-char) ;; to start of function name
			(let ((start (point)))
				(search-forward "(")
				(backward-char)
				(let ((funcname (filter-buffer-substring start (point))))
					(move-beginning-of-line nil)
					(backward-char)
					(insert funcname)))
			(insert "().\n */")
			(search-forward "_")
			(backward-char)
			(delete-region (point) (progn (forward-word -1) (point)))
			(insert modname)
			(let ((function (filter-buffer-substring (point-min) (point-max))))
				(kill-buffer)
				(filter-buffer-substring abbr-beginning abbr-end t t)
				(insert function))
			(backward-sexp)
			(forward-line)
			(back-to-indentation) t))))

(defun drupal-backward-abbrev ()
	"Move point to start of abbreviature."
	(let ((oldpoint) (newpoint) (symbol-regexp "\\(\\sw\\|\\s_\\|-\\)+"))
		(while (progn
						 (setq oldpoint (point))
						 (setq newpoint (re-search-backward symbol-regexp nil 'move))
						 (= oldpoint (+ newpoint 1))))
		(goto-char oldpoint)))

;;-----------------------------------------------------------------------------
;; Interactive functions
;;
(defun drupal-module-name-insert ()
	"Just insert Drupal module name at a point."
	(interactive)
	(insert (drupal-module-name)))

(defun drupal-browse-api ()
	"Browse Drupal API docs."
	(interactive)
	(browse-url
	 (format "%s/%i/%s" drupal-api-url drupal-api-version (symbol-at-point))))

(defun drupal-php-eval-region ()
  "Evaluate region of text as PHP code. Requires PHP CLI."
  (interactive)
  (let ((command (replace-regexp-in-string "<\\?php " "" (buffer-substring-no-properties (region-beginning) (region-end)))))
    (shell-command (format "%s -r '%s'" drupal-php-path command))))

;;-----------------------------------------------------------------------------
;; Flymake realtime syntax checking
;;

;; Static analysis can be slow, so only run flymake if I've not been typing for 5 seconds.
;; It will still run on save or hitting return.
(setq flymake-no-changes-timeout 3)

;; Disable in-place checking, and tell it to use ~/.emacs.d/tmp/ for the temp files.
(setq temporary-file-directory "/tmp/")
(setq flymake-run-in-place nil)

;; Tune how many checks can run in parallel, default of 4 should be fine.
(setq flymake-max-parallel-syntax-checks 4)

;; If flymake_phpcs isn't in your $PATH you'll need to give the full path here
(setq flymake-drupal-command (concat user-emacs-directory "bin/flymake_phpcs"))

(defun flymake-drupal-init ()
	(if drupal-flymake-use-codesniffer
			((let* ((temp-file (flymake-init-create-temp-buffer-copy
													(if (fboundp 'flymake-create-temp-copy)
															'flymake-create-temp-copy
														'flymake-create-temp-inplace)))
							(local-file (file-relative-name temp-file
																							(file-name-directory buffer-file-name))))
				 (list flymake-phpcs-command
							 (append
								(list local-file)
								(if drupal-flymake-standard
										(list (concat "--standard="
																	;; Looking for "/" is hardly portable
																	(if (string-match "/" drupal-flymake-standard)
																			(expand-file-name drupal-flymake-standard)
																		drupal-flymake-standard))))
								(list (concat "--error-severity=" (number-to-string drupal-flymake-error-severity)))
								(list (concat "--warning-severity=" (number-to-string drupal-flymake-warning-severity)))

								(if drupal-flymake-show-rule (list "-s"))))))
		(list drupal-php-path (list "-l"))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php\\'" flymake-drupal-init flymake-simple-cleanup flymake-get-real-file-name))
(add-to-list 'flymake-allowed-file-name-masks '("\\.module\\'" flymake-drupal-init flymake-simple-cleanup flymake-get-real-file-name))
(add-to-list 'flymake-allowed-file-name-masks '("\\.install\\'" flymake-drupal-init flymake-simple-cleanup flymake-get-real-file-name))
(add-to-list 'flymake-allowed-file-name-masks '("\\.inc\\'" flymake-drupal-init flymake-simple-cleanup flymake-get-real-file-name))
(add-to-list 'flymake-allowed-file-name-masks '("\\.engine\\'" flymake-drupal-init flymake-simple-cleanup flymake-get-real-file-name))

(eval-after-load "flymake"
  '(progn
		 (add-to-list 'flymake-err-line-patterns
			 (if drupal-flymake-use-codesniffer
					 '("\\(.*\\):\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)" 1 2 3 4)
				 '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2)))
		 (let ((mode-and-masks (flymake-get-file-name-mode-and-masks "example.php")))
			 (setcar mode-and-masks 'flymake-drupal-init))
		 (let ((mode-and-masks (flymake-get-file-name-mode-and-masks "example.module")))
			 (setcar mode-and-masks 'flymake-drupal-init))
		 (add-hook 'drupal-mode-hook (lambda() (flymake-mode 1)))))

;;-----------------------------------------------------------------------------
;; Yasnippet and TAGS templates

(define-key drupal-mode-map (kbd "<tab>") 'drupal-tab-invoke)

;;-----------------------------------------------------------------------------
;; Yasnippet
;;
(if (require 'yasnippet "yasnippet" t) ; TODO test it
		(progn
			(add-to-list 'yas/root-directory
									 (concat user-emacs-directory
													 (convert-standard-filename "snippets"))
									 (add-hook 'drupal-mode-hook (lambda ()
																								 (yas/initialize)
																								 (set-variable 'yas/fallback-behavior 'return-nil)
																								 (mapc 'yas/load-directory yas/root-directory))))))

;;-----------------------------------------------------------------------------
;; Keybindings
;;
(define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
(define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)
(define-key drupal-mode-map '[C-hf] 'drupal-browse-api)
(define-key drupal-mode-map "\C-cm" 'drupal-module-name-insert)
(define-key drupal-mode-map "\C-ce" 'drupal-php-eval-region) ;; but it conflicts with Cua mode

(defun drupal-tab-invoke ()
  "Try to execute appropriate action on pressed <tab> key.
Firstly try to expand word with `yasnippet'. Then try to
expand hook template prepared with TAGS. At last use default
`indent-for-tab-command' as php-mode does."
  (interactive)
	(cond
		((yas/expand))
		((drupal-hook-template-insert))
		((indent-for-tab-command))))

(define-minor-mode drupal-debug-mode
	"Minor mode for Drupal debugging. Mostly useless yet.
Currently it only highlights debugging functions in the code."
	:init-value nil ; TODO RULE#
	:lighter "/DBG"
	:group 'drupal
	:require 'drupal
	(font-lock-add-keywords nil ; TODO add other d* functions from devel module
													'(("\\(print_r\\|var_dump\\|dd\\)(.+);" 1 '(:background "red"))))) ; TODO move selection of face/color to defcustom

(provide 'drupal-mode)

;;; drupal-mode.el ends here