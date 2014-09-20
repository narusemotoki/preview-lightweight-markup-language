;;; preview-lightweight-markup-language.el --- Lightweight Markup Languages easy to preview.

;; Filename: preview-lightweight-markup-language.el
;; Description: Multiple scratches manager
;; Author: Motoki Naruse <motoki@naru.se>
;; Maintainer: Motoki Naruse <motoki@naru.se>
;; Copyright (C) 2014, Motoki Naruse, all rights reserved.
;; Created: 2014-09-17
;; Version: 0.1
;; Last-Updated: 2014-09-20
;;           By: Motoki Naruse
;; URL: https://github.com/narusemotoki/preview-lightweight-markup-language
;; Keywords:
;; Compatibility: GNU Emacs 24

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

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
