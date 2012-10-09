Flusher
=======

DNS cache flusher for Mac OS X. Tested with Mountain Lion, but it is prepared to work on at least Mac OS X 10.4.

This app is simply integrating into menu bar, and provides two menu item: `Flush DNS cache` and `Quit`.

Downloads
---------

If you want to get latest binary, visit the [Downloads section](https://github.com/hron84/Flusher/downloads), and download the latest DMG disk image.

Build app from source
---------------------

If you want to build this app from source, you need three easy step:

    git clone git://github.com/hron84/Flusher.git
    cd Flusher
    rake build

After building process finished, you will find result in **build/Release** folder.

**Note**: If you want to build Debug configuration, simply run 
`rake xcode:build:Flusher:Release` instead of `rake build`, and the result will be placed at **build/Debug** folder.

Known bugs / limitations
------------------------

The current version is uses sudo on Mac OS X 10.7 - 10.8 to flush DNS cache so you must have passwordless sudo configuration to flush DNS cache. It is easy to reach: open Terminal.app and enter `sudo nano /private/etc/sudoers`, find line what starts with @admin and type `NOPASSWD: ` before ALL at the end of line (note the space after the colon!).

In future versions this limitation might be removed.

If you found any other bug, please file an issue in [Issues section](https://github.com/hron84/Flusher/issues).

_(Boring stuffs coming so stop reading if you are not interested in them...)_

Licensing
---------

This app is licensed under the terms of CreativeCommons Attribution-NonCommercial-ShareAlike 2.0 license
For details, please see COPYING file in the root of the repository

Copyright (C) Gabor Garami 2012. Some rights reserved. 

Warranty
--------

This program is provided AS-IS **without warranty of any kind, express or implied**, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

The author offers some support for the application but reserves the right to deny any support requests without clarifying reason.