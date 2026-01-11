---
title: Web Server
layout: docs
author: iqbwl
---
Web Server is software that functions to receive requests from users via a web client or browser, then it will be responded by providing display/output according to the request sent to the server.

> A web server is computer software and underlying hardware that accepts requests via HTTP or its secure variant HTTPS. - [Wikipedia](https://en.wikipedia.org/wiki/Web_server)

For how it works like this, for example the client will access _iqbal.id_, then the web client sends a request to the web server and the web server receives the request.

Then the web server will read whether _iqbal.id_ is in the configuration, if the _iqbal.id_ configuration is found then the web server will look for the requested data.

![Web Server](/static/img/migrated/blog/img/web-server-process.png)

If it is found, it will be given to the web server and the web server will send the requested data to the web client.

There are several software that can be used as a web server such as Apache, Nginx, then Lighttpd or lighty and many more.
