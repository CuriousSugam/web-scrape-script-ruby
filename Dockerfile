FROM ruby:3.0

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN chmod +x app.rb
CMD ["./app.rb"]