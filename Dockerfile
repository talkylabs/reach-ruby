FROM ruby:2.4

RUN mkdir /talkylabs
WORKDIR /talkylabs

COPY . .

RUN bundle install
RUN bundle exec rake install
