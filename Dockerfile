FROM ruby:3.1.2
 
# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
 
# Set working directory
WORKDIR /app
 
# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.3.6
RUN bundle install
 
# Copy the rest of the app
COPY . .
 
# Precompile assets if needed
RUN bundle exec rake assets:precompile
 
# Start the app (adjust this depending on your web server)
CMD ["rails", "server", "-b", "0.0.0.0"]
