# Bird registry api service
Basic rails api to fetch birds data from MongoDB

#Setup and running the application
- Install Ruby 2.2.2
- brew install MongoDB
- gem install bundler
- bundle install --path .bundle
- bundle exec rake db:seed (To populate default birds data)

#To run the test suite

- bundle exec rspec spec

