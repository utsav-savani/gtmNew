from http.server import HTTPServer, BaseHTTPRequestHandler
import sys
import os

URL = os.environ['URL']
PORT_HTTPS = sys.argv[1]

main_url = URL + ":" + PORT_HTTPS

class myHandler(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(302)
    self.send_header('Location', main_url)
    self.end_headers()
PORT_HTTP = 80
handler = HTTPServer(("", PORT_HTTP), myHandler)
handler.serve_forever()
