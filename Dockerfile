FROM    debian:stable

RUN apt-get update && apt-get install -y \
    adduser \
    git \
    cron \
    rsync \
    nginx
    #apache2

RUN adduser \
    --system \
    --home=/opt/Juanbanpar/ \
    --shell=/bin/bash \
    --no-create-home \
    --group \
    archvsync

RUN mkdir -p /srv/mirrors/
RUN chown -R archvsync: /srv/mirrors
VOLUME ["/srv/mirrors"]

RUN ln -s /srv/mirrors /var/www/mirrors
#RUN mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.backup
#ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
#RUN echo "ServerName gul.es" | tee /etc/apache2/conf-available/fqdn.conf
#RUN a2enconf fqdn
#RUN apache2ctl configtest
ADD ftp.gul.es /etc/nginx/sites-available/ftp.gul.es
RUN ln -s /etc/nginx/sites-available/ftp.gul.es /etc/nginx/sites-enabled/ftp.gul.es
RUN rm /etc/nginx/sites-available/default
RUN rm /etc/nginx/sites-enabled/default
RUN service nginx start

RUN mkdir -p /opt/Juanbanpar/
WORKDIR /opt/Juanbanpar/
RUN git clone https://github.com/Juanbanpar/ftpsync.git
RUN chown -R archvsync:archvsync ./ftpsync
WORKDIR /opt/Juanbanpar/ftpsync/bin/
RUN chmod +x ./ftpsync

ADD crontab /etc/cron.d/simple-cron
RUN chmod 0644 /etc/cron.d/simple-cron
ADD script.sh /script.sh
RUN chmod +x /script.sh

#ENV PATH /opt/Juanbanpar/ftpsync/bin:${PATH}

#CMD cron
#CMD [cron && service nginx restart && "/bin/su -c "/bin/bash ftpsync/bin/ftpsync sync:all" - archvsync"]
#COPY start.sh start.sh
#RUN chmod +x start.sh
#CMD ["./start.sh"]
