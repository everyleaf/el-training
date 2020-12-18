FROM ruby:2.7.2
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        nodejs build-essential \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

ENV APP_ROOT /usr/src/app

WORKDIR $APP_ROOT

COPY ./Gemfile        $APP_ROOT/Gemfile
COPY ./Gemfile.lock   $APP_ROOT/Gemfile.lock

RUN bundle install

COPY . $APP_ROOT
