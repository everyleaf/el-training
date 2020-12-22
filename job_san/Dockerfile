FROM ruby:2.7.2
RUN curl https://deb.nodesource.com/setup_12.x | bash \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        nodejs build-essential yarn git vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV APP_ROOT /usr/src/app

WORKDIR $APP_ROOT

COPY ./Gemfile        $APP_ROOT/Gemfile
COPY ./Gemfile.lock   $APP_ROOT/Gemfile.lock

RUN bundle install

COPY . $APP_ROOT
