Sample Internet Files
=====================

WEBDIR
------

Usage:
1.  Modify the remote-directory variable in "webdir.cbl" if you want
    to use a remote data source.
2.  Compile "webdir.cbl" to "webdir.acu".
3.  Use your web browser to load "webdir.htm".

Description:
WEBDIR provides a simple URL list.  Each URL can be stored with a
title, a longer description and the actual URL. The user can
highlight the URL and click the Go! button, which loads the
URL either in the current browser window or in one of three others.

WEBINFO
-------

Usage:
1.  Compile "webinfo.cbl" to "webinfo.acu".
2.  Use your Web browser to load "webinfo.htm".

Description:
WEBINFO gathers information about its environment and displays it.
When WEBINFO is run within a browser, you can test "W$STATUS" and "W$GETURL".
You can also attempt to save this infomation in various directories.
You should only be able to write to directories listed in the
"acuauth.txt" file located in your browser's plugin directory.
