# 開發階段
FROM ruby:3.1.2 AS development
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN rake db:migrate && \
    rake db:seed
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]
# 生產階段
FROM ruby:3.1.2 AS production
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
COPY . /app
RUN rake db:migrate assets:precompile && \
    rake db:seed
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]

