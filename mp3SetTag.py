#
#  Compare to mp3SetTag.pl
#  The python version seems a bit better as it
#  allows to set album_artist.
#
import sys

# \Python27\Scripts\pip.exe install eyeD3
import eyed3

mp3_file     = sys.argv[1]
album        = sys.argv[2]
album_artist = None # album

mp3 = eyed3.load(mp3_file)
mp3.initTag()

mp3.tag.album        = unicode(album, 'ascii')
mp3.tag.album_artist = unicode(album, 'ascii')

mp3.tag.save()
