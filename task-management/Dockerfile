FROM ruby:2.6

# yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /task-management

WORKDIR /task-management
COPY Gemfile /task-management/Gemfile
COPY Gemfile.lock /task-management/Gemfile.lock
RUN bundle install
COPY . /task-management

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"] 
