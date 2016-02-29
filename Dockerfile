FROM zooniverse/ruby:jruby-9.0.5.0

WORKDIR /app

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && \
    apt-get install --no-install-recommends -y git curl supervisor  && \
    apt-get clean

ADD ./Gemfile /app/
ADD ./Gemfile.lock /app/

RUN bundle install

ADD supervisord.conf /etc/supervisor/conf.d/warehouse.conf
ADD ./ /app

VOLUME /var/log/warehouse

ENTRYPOINT ["/usr/bin/supervisord"]
