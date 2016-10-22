#!/bin/sh

git pull
bundle install
rails assets:precompile RAILS_ENV=production
kill `cat /var/tmp/unicorn.pid`
unicorn -c config/unicorn.rb -E production -D
