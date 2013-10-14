;;; drupal-init.el --- initialization of Emacs IDE for Drupal

;; Copyright © 2012 Alexander I.Grafov

;; Author: Alexander I.Grafov <axel@drupal.ru>
;; Version: 1.0-dev
;; Keywords: ide drupal php languages
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

;;; Usage:

;; Copy `drupal` folder to you Emacs configuration directory (`~/.emacs.d` on Unix
;; systems). Then copy text below to the end of Emacs init file:
;;
;;   ;; Start Drupal IDE with `drupal-ide' command:
;;   (setq drupal-ide-load-path (concat user-emacs-directory "drupal/drupal-init.el"))
;;   (autoload 'drupal-ide drupal-ide-load-path "Start IDE for PHP & Drupal development" t)
;;
;; This config will automatically load IDE functions and drupal-mode when you start IDE
;; with `M-x drupal-ide' command. If you use Emacs mostly for Drupal works to you may
;; explicitly load Drupal IDE on Emacs start with such init string::
;;
;;   ;; Drupal IDE
;;   (load (concat user-emacs-directory "drupal/drupal-init.el"))


;;; Commentary:

;; Emacs IDE for Drupal offer tools for programming in PHP/JS for Drupal CMS.
;; Customize IDE behaviour through `M-x set-variable' for defcustoms defined below.

;;; Code:

(defconst drupal-ide-version "1.0-dev"
  "Current version of Drupal mode.")

(defconst drupal-ide-modified "2012-04-16"
  "Drupal IDE build date.")

;;;###autoload
(defun drupal-ide ()
  "Display string describing the version of Drupal IDE."
  (interactive)
  (message "Drupal %s build date: %s"
					 drupal-ide-version
           drupal-ide-modified))

;;-----------------------------------------------------------------------------
;; Append IDE dirs on top of load-path
;;
(let ((default-directory (concat user-emacs-directory (convert-standard-filename "drupal"))))
	(setq load-path
				(append
				 (let ((load-path (copy-sequence load-path))) ;; Shadow
					 (append
						(copy-sequence (normal-top-level-add-to-load-path '(".")))
						(normal-top-level-add-subdirs-to-load-path)))
				 load-path)))

;;-----------------------------------------------------------------------------
;; Autoload Drupal related files
;;
(autoload 'drupal-mode "drupal-mode" "Major mode for Drupal." t)
  (add-to-list 'auto-mode-alist '("\\.\\(module\\|test\\|install\\|theme\\)$" . drupal-mode))
  (add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . drupal-mode))
  (add-to-list 'auto-mode-alist '("\\.info" . conf-windows-mode))

;; comment out string below if you want to fire php-mode on php-extensions
(setq auto-mode-alist (rassq-delete-all 'php-mode auto-mode-alist))

;; ============================================================================
;; Define variables customized in Emacs UI
;;
(defgroup drupal nil  ; method with custom variables taken from emacs_drupal_mode project
	"Drupal IDE"
	:link '(url-link :tag "Emacs IDE for Drupal" "http://drupal.org/project/emacs")
	:group 'tools)

(defcustom drupal-php-path "/usr/bin/php"
	"Path to PHP CLI."
	:group 'drupal)

(defcustom drupal-api-version 7
	"Drupal API version (major) to search."
	:type 'integer
	:group 'drupal)

(defcustom drupal-api-url "http://api.drupal.org/api/search"
	"URL for API search."
	:type 'string
	:group 'drupal)

(defcustom drupal-ide-use-etags nil
	"Use TAGS file prepared with etags/ctags for code navigation and hook templates.
See INSTALL.txt before using it."
	:type 'boolean
	:group 'drupal)

(defcustom drupal-flymake-use-codesniffer nil
	"Use Drupal or PHP Codesniffer library for syntax checks. By default `php -l` checks used."
	:type 'boolean
	:link '(url-link :tag "PHP_CodeSniffer" "http://pear.php.net/package/PHP_CodeSniffer")
	:group 'drupal)

(defcustom drupal-flymake-standard "Drupal"
  "The coding standard passed to phpcs via --standard."
  :type 'string
  :link '(url-link :tag "Drupal Code Sniffer" "http://drupal.org/project/drupalcs")
	:group 'drupal)

(defcustom drupal-flymake-error-severity 1
  "The minimum severity to display an error (--error-severity)."
  :type 'integer
	:group 'drupal)

(defcustom drupal-flymake-warning-severity 0
  "The minimum severity to display a warning (--warning-severity)."
  :type 'integer
	:group 'drupal)

(defcustom drupal-flymake-show-rule nil
  "Whether to display the name of the phpcs rule generating any errors or warnings."
  :type 'boolean
  :group 'drupal)

(defcustom drupal-debug-highlight nil
	"Highlght debug functions in the PHP code."
	:type 'boolean
	:group 'drupal)

(provide 'drupal-ide)

;;; drupal-init.el ends here
