#!/usr/bin/python
#use for socket detection, port manipulation, and IP watch.

import socket
import sys

if ( len(sys.argv) != 2 ):
    print "Usage: " + sys.argv[0] + " you must enter IP or FQDN along with your command"
    sys.exit(1)

remote_host = sys.argv[1]

for remote_port in [22,80,8080,993]:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(60)
        try:
                sock.connect((remote_host, remote_port))
        except Exception,e:
                print "%d closed " % remote_port
        else:
                print "%d open" % remote_port
        sock.close()
