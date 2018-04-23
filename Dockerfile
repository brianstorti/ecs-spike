FROM ruby:2.4.2

RUN mkdir /app && gem install sinatra

WORKDIR /app

COPY . /app

CMD ["ruby", "app.rb"]
