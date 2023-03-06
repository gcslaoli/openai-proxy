FROM ubuntu
ENV WORKDIR /app
RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
COPY frontend/dist $WORKDIR/public
COPY backend/main $WORKDIR/main
RUN chmod +x $WORKDIR/main
WORKDIR $WORKDIR
CMD ./main