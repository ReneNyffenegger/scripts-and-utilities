# Scripts and Utilities


Scripts and Utilities for cmd.exe and (ba)sh etc.

[`ghr.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/ghr.pl) is the script
I use to automatically pull or clone my [github repostiories](https://github.com/ReneNyffenegger?tab=repositories) when
I use a new computer or a computer on which I haven't worked for time.

[`git-push.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/git-push.pl) does a `git push` to the «correct»
server. Requires the *envorinment variable* `TQ84_GITHUB_PW` to be set with the password of the remote repository. In order to
automatically set this password, [`gitp.bat`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/gitp.bat) can
be used (on *cmd.exe*, that is).

[`cv.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/cv.pl) prints the content of the clipboard. Mnemonic: <b>C</b>trl-<b>V</b>.

[`createImage.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/createImage.pl) can be used to create simple images. For example
`createImage.pl -width=300 -height=150 -red=20 -green=40 -blue=200` create an 300x150 px image with an RGB background of #1428c8. The name of the
image is determined by its parameters: `img_300x150_20_40_200.png`.

[`dc.bat`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/dc.bat) `cd`s into the directory given and then also does a `dir`.

[`cdhom.bat`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/cdhom.bat) `cd` into the home directory (which is `%userprofile%` on Windows).

[`cdms.bat`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/cdms.bat), called as `cmds SomeName`, assigns *SomeName* with the current directory.
Later, [`cdm.bat`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/cdm.bat) allows to cd back to this directory (`cdm SomeName`).
cdm stands for *cd to mark*, cdms stands for *cd mark set*.

[`find_large_directories.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/find_large_directories.pl) iterates the sub directories of a given
directory and prints the sizes of these subdirectories. Can be used to find directories that occupy large portions on a file system. See
[`find_large_directories.test/find_large_directories.test.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/find_large_directories.test/find_large_directories.test.pl)
for a test case and some command line options.

[`hex_dump.pl`](https://github.com/renenyffenegger/scripts-and-utilities/blob/master/hex_dump.pl) (currently) shows the line
endings of text files. So, in that respect, it is *not yet a real hex dumper*!. Compare with [Data::HexDump](https://github.com/ReneNyffenegger/PerlModules/tree/master/Data/HexDump).

[`pathes.pl`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/pathes.pl) shows each path in `%PATH%` on a seperate line (Windows cmd.exe). Additionally, it
can be passed the name of a file to be searched in `%PATH%`.

[`svnlu.pl`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/svnlu.pl), to be exectued like so: `svnlu.pl  regexp`  basically issues an `svn list` and finds the files that match `regexp`.
Each file can be selected for update by pressing «y» or «j». A «q» prematurly exits the script. Every
other key skips the file.

[`red.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/red.bat), [`blue.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/blue.bat),
[`green.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/green.bat),
[`black.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/black.bat) and
[`black.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/black.bat) set the color of `cmd.exe` accordingly.

[`rec.pl`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/rec.pl) is a Perl script that recursively does <i>stuff</i> that I frequently need. <i>stuff</i> is
indicated by the option-flags given to the script.

[`ff_ftp.bat`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/ff_ftp.bat) opens fire fox with a `ftp://` url and a *username-password* tuple.
The username, password and host need to be stored in the env variables `tq84_XYZ_ftp_user`, `tq84_XYZ_ftp_pw` and `tq84_XYZ_ftp_host`, respectively. When the script
is called, it expects a parameter that is expanded to a value (in example above: `XYZ`).

[`profile.ps1`](https://github.com/ReneNyffenegger/scripts-and-utilities/blob/master/profile.ps1) is my startup script
for [powershell](https://github.com/ReneNyffenegger/about-powershell).

http://renenyffenegger.ch/notes/development/tools/scripts/personal/index
