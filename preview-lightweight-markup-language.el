(setq plml-directory (file-name-directory (or load-file-name (buffer-file-name))))
(setq plml-output-html-path "/tmp/plml.html")

(defun plml-gen-from-rst ()
  (interactive)
  (shell-command (format "python %srst.py %s > %s 2>&1" plml-directory buffer-file-name plml-output-html-path))
)

(defun plml-rst ()
  (interactive)
  (plml-gen-from-rst)
  (w3m-find-file plml-output-html-path)
)
