(defvar wordcount-timer nil
"Timer to kick off word count recomputation.")
 
(defvar wordcount-current-count 0
"The result of the last word count.")
 
(defun wordcount-update-word-count ()
"Recompute the word count."
(setq wordcount-current-count (count-words (point-min) (point-max))))
 
(define-minor-mode wordcount-mode
"Toggle wordcount mode.
With no argument, this command toggles the mode.
A non-null prefix argument turns the mode on.
A null prefix argument turns it off.
 
When enabled, the word count for the current buffer
is displayed in the mode-line."
:init-value nil
:lighter (:eval (format " [%d words]" wordcount-current-count))
(if wordcount-mode
(progn
(set (make-local-variable 'wordcount-current-count)
(count-words (point-min) (point-max)))
(set (make-local-variable 'wordcount-timer)
(run-with-idle-timer 3 't #'wordcount-update-word-count)))
(cancel-timer wordcount-timer)))
 
(add-hook 'text-mode-hook (lambda () (wordcount-mode)))
