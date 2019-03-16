#
#    https://stackoverflow.com/a/41195176
#


add-type shell32 @'

    [DllImport("shell32.dll")]

    public static extern int SHEmptyRecycleBin(
        IntPtr hwnd,
        string pszRootPath,
        int    dwFlags
    );

'@ -Namespace System

$SHERB_NOCONFIRMATION = 0x1
$SHERB_NOPROGRESSUI   = 0x2
$SHERB_NOSOUND        = 0x4

$dwFlags              = $SHERB_NOCONFIRMATION

$res = [shell32]::SHEmptyRecycleBin([IntPtr]::Zero, $null, $dwFlags)

if ($res) { "Error 0x{0:x8}: {1}" -f $res,`
    (new-object ComponentModel.Win32Exception($res)).Message
}
exit $res
