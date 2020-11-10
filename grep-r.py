import re
import os
import sys

if len(sys.argv) < 2:
   print('Expected: regular expression')
   sys.exit(-1)

regexpText = sys.argv[1]

print('regexpText = ' + regexpText)

fileEncoding = 'latin1'
fileSuffix   = 'sql'

def findPattern(fileName, regexp):

    if 'archiv' in fileName.lower():
        return

    with open(fileName, encoding=fileEncoding) as file:
         for line in file:
             match = regexp.search(line)

             if match:
                print('{:140s} {}'.format(match.group(0), fileName))


def walkTree(under, regepx):

    for curDir, dirs, files in os.walk(under):
     #
     #  - curDir: a string that contains the relative path to the «current» directory
     #
     #  - dirs:   a list of strings, each of which is a directory name that is present
     #            in the «current» directory.
     #
     #  - files:  a list of strings, each of which is a file name that is present
     #            in the «current» directory.

        depth = curDir.count(os.sep)

        for file in filter(lambda F: F.lower().endswith('.' + fileSuffix), files):
            findPattern(curDir + '/' + file, regexp)

regexp = re.compile(regexpText, re.I)
walkTree('.', regexp)
