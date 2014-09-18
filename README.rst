===================================
Preview Lightweight Markup Language
===================================
This elisp makes Lightweight Markup Languages easy to write and preview.

-------
Install
-------

Append these lines to your ~/.emacs.d/init.el.

::

    (setq load-path (cons "/path/to/preview-lightweight-markup-language" load-path))
    (load "preview-lightweight-markup-language")

This elisp depends on Python and the libraries.
::

    $ sudo pip install -r requirements.txt

And `w3m <http://w3m.sourceforge.net/index.en.html>`_.

---------------
How to use this
---------------
If you don't use this elisp yet, run "M-x plml-rst". Otherwise run "M-x plml-gen-from-rst" and type R on w3m buffer.

----
ToDo
----
* Auto refresh
* Implements Firefox option.
* Implements another languages. (e.g. Markdown)
