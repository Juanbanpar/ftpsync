FROM    debian:stable

RUN apt-get update && apt-get install -y \
    adduser \
    git \
    cron \
    rsync

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
#CMD ["/bin/su -c "/bin/bash ftpsync/bin/ftpsync sync:all" - archvsync"]
