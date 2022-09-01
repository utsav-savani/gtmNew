import http.server
import ssl, sys, os

URL = os.environ['URL']
PORT_HTTPS = int(sys.argv[1])
main_url = os.environ['URL'] + ":" + sys.argv[1]

cwd = os.getcwd()
wd = "/app/server"
routes = ["/dashboard", "/welcome", "/login"]

class myHandler(http.server.SimpleHTTPRequestHandler):
        def do_GET(self):
                #if self.path == "/dashboard" or not self.path.endswith('/'):
                path = self.translate_path(self.path)
                if not os.path.exists(path):
                        self.send_response(302)
                        self.send_header('Content-Type', 'text/html')
                        self.send_header('location', main_url)
                        self.end_headers()
                else:
                        http.server.SimpleHTTPRequestHandler.do_GET(self)

httpd = http.server.HTTPServer(('0.0.0.0', PORT_HTTPS), myHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
        server_side = True,
        keyfile = wd + "/wildcard_uas_aero.key",
        certfile = wd + "/wildcard_uas_aero.crt",
        ssl_version = ssl.PROTOCOL_SSLv23 )
httpd.serve_forever()

# import http.server
# import ssl
# import sys
# import os

# PORT = int(sys.argv[1])
# cwd = os.getcwd()
# sname = "qa-gtm.uas.aero"

# print("cwd =" + cwd)

# wd = "/app/server"

# httpd = http.server.HTTPServer(('0.0.0.0', PORT), http.server.SimpleHTTPRequestHandler)
# httpd.socket = ssl.wrap_socket(httpd.socket,
#         server_side = True,
#         keyfile = wd + "/wildcard_uas_aero.key",
#         certfile = wd + "/wildcard_uas_aero.crt",
#         ssl_version = ssl.PROTOCOL_SSLv23 )
# httpd.serve_forever()