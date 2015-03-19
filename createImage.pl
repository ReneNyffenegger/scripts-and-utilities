use warnings;
use strict;

use GD;
use Getopt::Long;

my $width     =   1;
my $height    =   1;
my $bgColor_r = 255;
my $bgColor_g = 255;
my $bgColor_b = 255;
my $bgAlpha   =   0; # 0 .. 127

die unless GetOptions (
  'width=i'                  => \$width,
  'height=i'                 => \$height,
  'red=i'                    => \$bgColor_r,
  'green=i'                  => \$bgColor_g,
  'blue=i'                   => \$bgColor_b,
  'alpha=i'                  => \$bgAlpha
);

my $image = new GD::Image($width, $height);

my $bgColor = $image->colorAllocateAlpha($bgColor_r, $bgColor_g, $bgColor_b, $bgAlpha);
$image -> fill(0, 0, $bgColor);

my $filename = "img_${width}x${height}_${bgColor_r}_${bgColor_g}_${bgColor_b}_${bgAlpha}.png";

open my $out, '>', $filename;
binmode $out;
print   $out $image->png;
close   $out;
