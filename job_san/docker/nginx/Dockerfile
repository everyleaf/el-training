FROM  nginx:latest

RUN rm -f /etc/nginx/conf.d/* && mkdir -p /var/tmp/nginx/

COPY ./nginx.conf /etc/nginx/conf.d/job_san.conf
COPY ./maintenance.html /var/www/html/static/maintenance.html

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/conf.d/job_san.conf
