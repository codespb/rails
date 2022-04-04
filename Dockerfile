FROM ruby:alpine

RUN apk --update add build-base nodejs yarn tzdata curl \
    ruby-nokogiri \
    mariadb-dev \
    libxslt-dev libxml2-dev imagemagick vips-dev \
    git openssl \
    ffmpeg \
    gcompat zsh bash \
    && rm -f /var/cache/apk/*

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ENV INSTALL_PATH /app
ENV BUNDLE_PATH /bundle
RUN gem install bundler && gem install rails 
WORKDIR $INSTALL_PATH
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
VOLUME [ $BUNDLE_PATH ]
# VOLUME [ "/usr/local/bundle" ]
# VOLUME [ "/root/.local/share/gem/ruby/3.1.0" ]
# VOLUME [ "/usr/local/lib/ruby/gems/3.1.0" ]
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["rails","s","-b","0.0.0.0","-p","3000"]