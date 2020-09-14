FROM    debian:stable

RUN apt-get update && apt-get install -y \
    apache \
    adduser \
    git \
    cron \
    rsync

RUN adduser --disabled-password archvsync

RUN mkdir -p /srv/mirrors
VOLUME ["/srv/mirrors"]
RUN chown -R archvsync:archvsync /srv/mirrors

RUN mkdir -p /opt/Juanbanpar/
WORKDIR /opt/Juanbanpar/
RUN git clone https://github.com/Juanbanpar/ftpsync.git
RUN chown -R archvsync:archvsync ./ftpsync

#ENV PATH /opt/Juanbanpar/archvsync/bin:${PATH}

#CMD ["/bin/bash ftpsync sync:all"]
# /bin/su -c "/bin/bash archvsync/bin/ftpsync sync:all" - archvsync
