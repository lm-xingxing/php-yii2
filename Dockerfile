FROM dmstr/php-yii2:7.1-fpm-3.2-nginx

# Customize any core extensions here
#COPY sources.list /etc/apt/sources.list
#RUN rm -f /etc/apt/sources.list.d/*
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apt-get update && apt-get install -y \
         net-tools \
         procps \
         wget
# install redis extension
ADD phpredis /usr/src/php/ext/phpredis
WORKDIR /usr/src/php/ext/phpredis
RUN cd /usr/src/php/ext/phpredis && phpize
RUN ./configure && make && make install
ADD docker-php-ext-redis.ini /usr/local/etc/php/conf.d/docker-php-ext-redis.ini

# install pcntl extension
WORKDIR /usr/src/php/ext/pcntl
RUN cd /usr/src/php/ext/pcntl && phpize
RUN ./configure && make && make install
ADD docker-php-ext-pcntl.ini /usr/local/etc/php/conf.d/docker-php-ext-pcntl.ini

RUN chmod 777 /tmp
