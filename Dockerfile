FROM  ubuntu:22.10

COPY ./1.12 /var/www/html

WORKDIR  /var/www/html

#install vim
RUN  apt  update && apt install -y vim

EXPOSE 9000

# run bash
CMD [ "bash" ]
