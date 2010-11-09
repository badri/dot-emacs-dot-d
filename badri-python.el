;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python mode customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
	    interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
		    (set-variable 'py-python-command "/usr/bin/python")
		    (set-variable 'py-indent-offset 4)
		    (set-variable 'py-smart-indentation nil)
		    (set-variable 'indent-tabs-mode nil) 
	 )
      )
)


;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; (brm-init)
(require 'pycomplete)
(add-to-list 'load-path "~/.emacs.d/mmm-mode")
(require 'mmm-auto)
(require 'doctest-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Put the following in your .emacs so that the
;; abbrev table is set correctly in all modes.
;; (Not just for java)
;;
;; (add-hook 'pre-abbrev-expand-hook 'abbrev-table-change)
;; (defun abbrev-table-change (&optional args)
;;   (setq local-abbrev-table
;; 	(if (eq major-mode 'jde-mode)
;; 	    (if (jde-parse-comment-or-quoted-p)
;; 		text-mode-abbrev-table
;; 	      java-mode-abbrev-table)
;; 	  (if (eq major-mode 'python-mode)
;; 	      (if (inside-comment-p)
;; 		  text-mode-abbrev-table
;; 		python-mode-abbrev-table
;; 		))))
;;   )
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Snippets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(snippet-with-abbrev-table 'python-mode-abbrev-table
;			   ("hdr" .  "#!/usr/bin/env python\n# -*- coding: utf-8 -*-\n\"\"\"\n\"\"\"\n\n__author__ = \"Badri <badri.dilbert@gmail.com>\"")
;			   ("main" .  "if __name__ == \"__main__\":\n$>")
;			   ("cls" . "class $${class_name}($${object}):\n$>\"\"\"\n$>$${class documentation}\n$>\"\"\"\n$>$.")
;			   )

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
