FROM ruby:3.0.3


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client
RUN apt-get update && apt-get install -y postgresql-client

ENV APP_PATH /myapp


RUN mkdir $APP_PATH
WORKDIR $APP_PATH


COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock
RUN bundle install


COPY . $APP_PATH

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


# Add rails command to the PATH
RUN ln -s /usr/local/bundle/bin/rails /usr/local/bin/rails

# Add bin directory to the PATH
ENV PATH="/rails/bin:${PATH}"

# ENTRYPOINTとCMDを明示的に設定
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]