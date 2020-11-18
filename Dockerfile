FROM wordpress

RUN apt-get update
RUN apt-get -y install rsync
RUN apt-get -y install openssh-client
RUN apt-get -y install default-mysql-client
RUN mkdir ~/.ssh
RUN echo 'IdentityFile ~/.ssh-local/id_rsa' > ~/.ssh/config
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp-cli.phar && \
    echo '#!/bin/sh' >> /usr/local/bin/wp && \
    echo 'wp-cli.phar "$@" --allow-root' >> /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]