
<!--#echo json="package.json" key="name" underline="=" -->
systemd-escape-pmb
==================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
(Un)Escape strings and paths for use as systemd unit name parts.
<!--/#echo -->



API
---

This module exports an object that holds these functions:

### escapeNonPath(s)

String &rarr; String.
Escape a string exactly.

### escapePath(s)

String &rarr; String.
Normalize and then escape an absolute path.

### unescapeNonPath(s)

String &rarr; String.
Decode an escaped string.

### unescapePath(s)

String &rarr; String.
Decode an escaped path.







<!--#toc stop="scan" -->



Known issues
------------

* Needs more/better tests and docs.




&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->
