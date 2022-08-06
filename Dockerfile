FROM mongo:latest

LABEL maintainer="DuongLQ <duonglq@solutions101.org>" 

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
 && apt-get install curl \
 && apt-get install unzip

RUN curl https://rclone.org/install.sh | bash
RUN curl -L https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron
RUN chmod u+x /usr/local/bin/go-cron

RUN apt-get remove unzip -y

RUN rm -rf /var/cache/apk/*

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN mkdir /rclone
RUN touch /rclone/rclone.conf

COPY backup.sh /app/backup.sh
RUN chmod +x /app/backup.sh

COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

CMD ["sh", "run.sh"]
