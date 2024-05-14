FROM nginx
WORKDIR /home/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./miniserver.c .
COPY ./runner.sh .
RUN apt-get update && \
    apt-get install -y gcc make libfcgi-dev spawn-fcgi && \
	gcc -o miniserver miniserver.c -lfcgi && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN useradd --create-home kenyaqui && \
    chown -R kenyaqui /home
USER kenyaqui
ENTRYPOINT ["sh", "./runner.sh"]
