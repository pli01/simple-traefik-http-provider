# simple-traefik-http-provider
Simple demo of routing with traefik-http-provider

* traefik container with http provider: listening on `http://127.0.0.1:80/`
* httpd container hosting dynamic_conf.json : `http://httpd/dynamic_conf.json`
* 2 whoami container displaying usefull information (hostname IP)  on `http://whoami1 or http://whoami2`

* [docker-compose file](docker-compose.yml)
* [dynamic_conf.json file](dynamic_conf.json)

# Use it
```
$docker-compose up
Creating network "traefik_default" with the default driver
Creating traefik_traefik_1 ... 
Creating traefik_httpd_1   ... 
Creating traefik_whoami2_1 ... 
Creating traefik_whoami1_1 ... 
```

# Test it
```

curl -H 'Host: whoami.mydomain.local' http://127.0.0.1
Hostname: 1f0258d36282
IP: 127.0.0.1
IP: 172.18.0.4
RemoteAddr: 172.18.0.3:54278
GET / HTTP/1.1
Host: whoami.mydomain.local
User-Agent: curl/7.54.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 172.18.0.1
X-Forwarded-Host: whoami.mydomain.local
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: 785cdabbba68
X-Real-Ip: 172.18.0.1

curl -H 'Host: whoami.mydomain.local' http://127.0.0.1
Hostname: 1f0258d36282
IP: 127.0.0.1
IP: 172.18.0.4
RemoteAddr: 172.18.0.3:54278
GET / HTTP/1.1
Host: whoami.mydomain.local
User-Agent: curl/7.54.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 172.18.0.1
X-Forwarded-Host: whoami.mydomain.local
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: 785cdabbba68
X-Real-Ip: 172.18.0.1
```
