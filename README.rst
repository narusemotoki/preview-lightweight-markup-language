===================================
Preview Lightweight Markup Language
===================================
This elisp makes Lightweight Markup Languages easy to write and preview.
Emacs call Python script that compile reStructuredText or Markdown document to HTML. And open that on Firefox.

-----------------
Support languages
-----------------
* reStructuredText
* Markdown

-------
Install
-------

Append these lines to your ~/.emacs.d/init.el.
::

    (setq load-path (cons "/path/to/preview-lightweight-markup-language" load-path))
    (load "preview-lightweight-markup-language")

This elisp depends on Python and libraries.
::

    $ sudo pip install -r requirements.txt

And `moz.el <https://github.com/bard/mozrepl/wiki/Emacs-integration>`_.

Install `MozRepl <https://addons.mozilla.org/en-US/firefox/addon/mozrepl/>`_ to your Firefox.

---------------
How to use this
---------------
If you don't use this elisp yet, run "M-x plml-rst". Otherwise run "M-x plml-gen-from-rst" and type R on w3m buffer.

-----
Extra
-----
If you want auto-reload, you add these:
::

    (add-hook 'rst-mode-hook
              '(lambda ()
                (add-hook 'after-save-hook 'plml-rst-reload)))

    (add-hook 'markdown-mode-hook
              '(lambda ()
                (add-hook 'after-save-hook 'plml-markdown-reload)))

-----
Video
-----
https://www.youtube.com/watch?v=MET6vM7FXMQ&feature=youtu.be
