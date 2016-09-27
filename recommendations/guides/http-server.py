from SimpleHTTPServer import SimpleHTTPRequestHandler
import BaseHTTPServer
import os

class CORSRequestHandler (SimpleHTTPRequestHandler):

    def end_headers (self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET')
        self.send_header('Access-Control-Allow-Headers', '*')
        self.send_header('Access-Control-Allow-Headers', 'Pragma,Cache-Control,If-Modified-Since,Content-Type,X-Requested-With,X-stream,X-Ajax-Browser-Auth')
        SimpleHTTPRequestHandler.end_headers(self)

    def do_OPTIONS(self):
        self.send_response(200)
#        self.send_header('Access-Control-Allow-Origin', '*')
#        self.send_header('Access-Control-Allow-Methods', 'GET, OPTIONS')
#        self.send_header("Access-Control-Allow-Headers", "X-Requested-With")
#        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()

if __name__ == '__main__':
    BaseHTTPServer.HTTPServer(("0.0.0.0", 8001), CORSRequestHandler).serve_forever()

#    BaseHTTPServer.test(CORSRequestHandler, BaseHTTPServer.HTTPServer)
