#  Compare to mp3SetTag.py
#  The python version seems a bit better as it
#  allows to set album_artist.
#
use warnings;
use strict;

use MP3::Tag;

my $mp3_file = shift or die;
my $album    = shift or die;

my $mp3 = new MP3::Tag($mp3_file);

$mp3->album_set($album);
$mp3->update_tags();
