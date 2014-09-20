(setq plml-directory (file-name-directory (or load-file-name (buffer-file-name))))
(setq plml-output-html-path "/tmp/plml.html")
(setq plml-output-html-file-path (concat "file://" plml-output-html-path))

(require 'moz)

; Thank you http://d.hatena.ne.jp/yuto_sasaki/20120318/1332057960
(defun moz-send-message (moz-command)
  (comint-send-string
   (inferior-moz-process)
   (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
           moz-repl-name ".setenv('inputMode', 'line'); "
           moz-repl-name ".setenv('printPrompt', false); undefined; "))
  (comint-send-string
   (inferior-moz-process)
   (concat moz-command
           moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n")))

(defun moz-open-uri-in-new-tab (uri)
  (moz-send-message
   (concat
    "gBrowser.selectedTab = gBrowser.addTab();\n"
    (format "content.location=\"%s\";\n" uri)))
  )

(defun plml-reload-firefox ()
  (comint-send-string (inferior-moz-process) (format "
(function() {
    for(var i = 0; i < gBrowser.browsers.length; i++) {
        if (gBrowser.getBrowserAtIndex(i).currentURI.spec === '%s') {
            gBrowser.selectedTab = gBrowser.tabContainer.childNodes[i];
            BrowserReload();
        }
    }
})();
" plml-output-html-file-path)))

(defun plml-auto-preview ()
    (plml-gen-from-rst)
    (plml-reload-firefox))

;(add-hook 'after-save-hook 'plml-auto-preview)

(defun plml-gen-from-rst ()
  (interactive)
  (shell-command (format "python %srst.py %s > %s 2>&1" plml-directory buffer-file-name plml-output-html-path))
)

(defun plml-rst ()
  (interactive)
  (plml-gen-from-rst)
  (moz-open-uri-in-new-tab plml-output-html-file-path)
)

(defun plml-gen-from-markdown ()
  (interactive)
  (shell-command (format "markdown_py %s > %s 2>&1" buffer-file-name plml-output-html-path))
)

(defun plml-markdown ()
  (interactive)
  (plml-gen-from-markdown)
  (moz-open-uri-in-new-tab plml-output-html-file-path)
)
