FROM ruby:alpine

RUN apk --update add build-base nodejs yarn tzdata curl \
    ruby-nokogiri \
    mariadb-dev \
    vips-dev \
    git \
    gcompat \
    && rm -f /var/cache/apk/*
ENV INSTALL_PATH=/app BUNDLE_PATH=/bundle
RUN gem install bundler && gem install rails
WORKDIR $INSTALL_PATH
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["rails","s","-b","0.0.0.0","-p","3000"]