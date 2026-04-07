FROM ruby:3.3.6

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  npm \
  postgresql-client \
  git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN gem install bundler
