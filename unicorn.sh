#!/bin/sh

kill `cat /var/tmp/unicorn.pid`
unicorn -c config/unicorn.rb -E production -D
