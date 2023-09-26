FROM alpine:latest as nginx

RUN apk add --no-cache nginx gettext-envsubst bash
RUN mkdir -p /etc/nginx/template.d /etc/nginx/vhost.d /home/www/public_html
RUN chmod 777 /home/www/public_html
RUN echo "<h1><center>NGINX WORKS</center></h1>" >> /home/www/public_html/index.html

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint /usr/bin/entrypoint
COPY default.template /etc/nginx/template.d/
RUN chmod +x /usr/bin/entrypoint

EXPOSE 80

ENTRYPOINT [ "entrypoint" ]

FROM nginx