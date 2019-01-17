'
'      Note: needs to be invoked with cscript (rather than
'            wscript) in order for wscript.echo print to
'            the console
'
option explicit

dim args
dim method
dim url
dim xmlhttp

set args = wscript.arguments

if args.count < 1 then
   wscript.echo "No URL provided"
   wscript.quit
end if

set xmlhttp = createObject("MSXML2.xmlHTTP")

method = "GET"
url    = args(0)

wscript.echo "URL: " & url

xmlhttp.open "GET", url, false
xmlhttp.send

wscript.echo "Status: " & xmlhttp.status

if xmlhttp.status <> 200 then
   wscript.echo "Status: " & xmlhttp.status
end if

wscript.echo xmlhttp.responseText
