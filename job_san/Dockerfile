FROM ruby:2.7.2
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        nodejs lsb-release \
     && apt remove -y libmariadb-dev-compat libmariadb-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

RUN wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-common_8.0.18-1debian10_amd64.deb \
    https://dev.mysql.com/get/Downloads/MySQL-8.0/libmysqlclient21_8.0.18-1debian10_amd64.deb \
    https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client-core_8.0.18-1debian10_amd64.deb \
    https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client_8.0.18-1debian10_amd64.deb \
    https://dev.mysql.com/get/Downloads/MySQL-8.0/libmysqlclient-dev_8.0.18-1debian10_amd64.deb

RUN dpkg -i mysql-common_8.0.18-1debian10_amd64.deb \
    libmysqlclient21_8.0.18-1debian10_amd64.deb \
    mysql-community-client-core_8.0.18-1debian10_amd64.deb \
    mysql-community-client_8.0.18-1debian10_amd64.deb \
    libmysqlclient-dev_8.0.18-1debian10_amd64.deb

ENV APP_ROOT /usr/src/app
WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN gem install bundler && bundle install
