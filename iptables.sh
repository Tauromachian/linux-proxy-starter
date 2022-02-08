#!/bin/bash

# Configura iptables para que todo el trafico local vaya directamente y el resto
# siempre que tenga autorizacion (grupo socksified) vaya a internet a traves de redsocks

# Create new chain
iptables -t nat -N REDSOCKS

# Ignore LANs and some other reserved addresses.
# See http://en.wikipedia.org/wiki/Reserved_IP_addresses#Reserved_IPv4_addresses
# and http://tools.ietf.org/html/rfc5735 for full list of reserved networks.
iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 100.64.0.0/10 -j RETURN
iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 198.18.0.0/15 -j RETURN
iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

# Anything else should be redirected to port 12345
#iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345 and 12346

iptables -t nat -A REDSOCKS -p tcp --dport 80 -j REDIRECT --to-ports 12346
iptables -t nat -A REDSOCKS -p tcp --dport 443 -j REDIRECT --to-ports 12345
iptables -t nat -A REDSOCKS -p tcp --dport 11371 -j REDIRECT --to-ports 12346

iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345

# Any tcp connection made should be redirected to the REDSOCKS CHAIN.
iptables -t nat -A OUTPUT -p tcp -j REDSOCKS

# In case you are redirecting other computer thru this one
# iptables -t nat -A PREROUTING -p tcp --dport 11371 -j REDSOCKS
# iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDSOCKS
# iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDSOCKS
