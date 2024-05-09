FROM ruby:3.1.2
ENV LANG C.UTF-8
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      default-mysql-client \
      nodejs \
      jq \
      git \
      curl \
      python3 \
      less \
      npm
RUN npm install --global yarn

ENV APP_ROOT /myapp
RUN mkdir /$APP_ROOT
WORKDIR /$APP_ROOT

COPY Gemfile /$APP_ROOT/Gemfile
COPY Gemfile.lock /$APP_ROOT/Gemfile.lock

RUN bundle install

COPY . /$APP_ROOT
