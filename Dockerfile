FROM openjdk:dev

RUN mkdir -p /etc/cas

COPY etc/cas /etc/cas
COPY docker/entrypoint.sh /
COPY target/cas.war /

RUN chmod a+x /entrypoint.sh

CMD ["/entrypoint.sh"]
