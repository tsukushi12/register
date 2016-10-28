#!/bin/sh

DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:migrate:reset RAILS_ENV=production
rails db:seed RAILS_ENV=production
