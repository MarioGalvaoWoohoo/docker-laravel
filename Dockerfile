FROM php:7.3.6-fpm-alpine3.9

#Instalação do bash mysql-client shadow
RUN apk add --no-cache openssl bash mysql-client shadow

#Instalação da extenções do pdo pdo_mysql
RUN docker-php-ext-install pdo pdo_mysql

#Instalação do dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

#Inicia o container nesse path
WORKDIR /var/www

#Remove tudo de path
RUN rm -rf /var/www/html 

#Responsável por baixar, instalar e colocar no /usr/local/bin o composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


RUN chown -R www-data:www-data /var/www
RUN ln -s public html
RUN usermod -u 1000 www-data

USER www-data

#Libera a porta 9000 para acesso ao container
EXPOSE 9000

#Responsavel por manter o container up, executando o comando php-fpm do alpine
ENTRYPOINT ["php-fpm"]

