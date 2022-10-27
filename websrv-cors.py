# Found at
#
#   https://fpira.com/blog/2020/05/python-http-server-with-cors
#
from http.server import HTTPServer, SimpleHTTPRequestHandler
import sys


class CORSRequestHandler(SimpleHTTPRequestHandler):

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin' , '*')
        self.send_header('Access-Control-Allow-Methods', '*')
        self.send_header('Access-Control-Allow-Headers', '*')
        self.send_header('Cache-Control'                , 'no-store, no-cache, must-revalidate')
        return super(CORSRequestHandler, self).end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

port = int(sys.argv[1]) if len(sys.argv) > 1 else  8080
host =     sys.argv[2]  if len(sys.argv) > 2 else '0.0.0.0'

print("Listening on {}:{}".format(host, port))

httpd = HTTPServer((host, port), CORSRequestHandler)
httpd.serve_forever()
