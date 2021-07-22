FROM nginx:1.15.0-alpine

#Remove as config do nginx default e coloca as minhas config.
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d