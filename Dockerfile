FROM ruby:2.1

RUN apt-get update

RUN apt-get install -y libffi-dev build-essential libxml2 libxml2-dev libxslt1-dev sqlite3 libsqlite3-dev

RUN mkdir -p /scribd

WORKDIR /scribd

RUN gem install bundler -v 1.10.6

ADD Gemfile* /scribd/

RUN bundle install






