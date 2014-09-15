# Scripts and Utilities


Scripts and Utilities for cmd.exe and (ba)sh etc.

[`github_repos.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/github_repos.pl) is the script
I use to automatically pull or clone my [github repostiories](https://github.com/ReneNyffenegger?tab=repositories) when
I use a new computer or a computer on which I haven't worked for time.

[`git-push.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/git-push.pl) does a `git push` to the «correct»
server. Requires the *envorinment variable* `TQ84_GITHUB_PW` to be set with the password of the remote repository. In order to
automatically set this password, [`gitp.bat`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/gitp.bat) can
be used (on *cmd.exe*, that is).

[`cv.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/cv.pl) prints the content of the clipboard. Mnemonic: <b>C</b>trl-<b>V</b>.

[`dc.bat`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/dc.bat) `cd`s into the directory given and then also does a `dir`.

[`hex_dump.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/hex_dump.pl) (currently) shows the line
endings of text files. So, in that respect, it is *not yet a real hex dumper*!. Compare with [Data::HexDump](https://github.com/ReneNyffenegger/PerlModules/tree/master/Data/HexDump).

[`svnlu.pl`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/svnlu.pl), to be exectued like so: `svnlu.pl  regexp`  basically issues an `svn list` and finds the files that match `regexp`.
Each file can be selected for update by pressing «y» or «j». A «q» prematurly exits the script. Every
other key skips the file.

[`red.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/red.bat), [`blue.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/blue.bat),
[`green.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/green.bat) and
[`black.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/black.bat) set the color of `cmd.exe` accordingly.

[`ff_ftp.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/ff_ftp.bat) opens fire fox with a `ftp://` url and a *username-password* tuble.
The username, password and host need to be stored in the env variables `tq84_XYZ_ftp_user`, `tq84_XYZ_ftp_pw` and `tq84_XYZ_ftp_host`, respectively. When the script
is called, it expects a parameter that is expanded to a value (in example above: `XYZ`).
