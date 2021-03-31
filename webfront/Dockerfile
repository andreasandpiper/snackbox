FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
ENV RAILS_ROOT /var/www/snackbox
WORKDIR $RAILS_ROOT
RUN mkdir log
COPY nginx.conf /tmp/docker.nginx
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]