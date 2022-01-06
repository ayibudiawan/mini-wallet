# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.6.3

* System dependencies
  posgresql > 10
  if you haven't installed it you can installed in using this guide https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart
  ubuntu 20

* Configuration
  setup .env.development in root path using this value
  `
  DATABASE_HOST="localhost"
  DATABASE_USERNAME="ayi"
  DATABASE_PASSWORD="ayibudiawan"
  DATABASE_NAME="mini_wallet_development"
  `
  if above environment already added run bundle install

* Database creation
  bundle exec rake db:create

* Database initialization
  bundle exec rake db:migrate
  bundle exec rake db:seed

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
