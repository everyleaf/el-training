FROM ruby:2.6

ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      nodejs \
      default-mysql-client \
      jq \
      git \
      curl \
      python3 \
      less

ENV APP_ROOT /training
RUN mkdir /$APP_ROOT
WORKDIR /$APP_ROOT

COPY Gemfile /$APP_ROOT/Gemfile
COPY Gemfile.lock /$APP_ROOT/Gemfile.lock
ENV BUNDLE_PATH=/usr/local/bundle
RUN bundle install

COPY . /$APP_ROOT
