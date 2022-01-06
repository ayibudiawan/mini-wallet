# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  - 2.6.3

* System dependencies
  - posgresql > 10, if you haven't installed it you can installed in using this guide https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart
  - ubuntu 20

* Configuration
  - setup .env.development in root path using this value
  <code>
    DATABASE_HOST="localhost"
    DATABASE_USERNAME="your_username"
    DATABASE_PASSWORD="your_password"
    DATABASE_NAME="database_name"
  </code>
  - run bundle install

* Database creation
  - bundle exec rake db:create

* Database initialization
  - bundle exec rake db:migrate
  - bundle exec rake db:seed
