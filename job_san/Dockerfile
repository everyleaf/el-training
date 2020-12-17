FROM ruby:2.5.8
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        nodejs \
        mariadb-client \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

ENV APP_ROOT /usr/src/app
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT
COPY ./Gemfile.lock $APP_ROOT

RUN gem install bundler && bundle install
