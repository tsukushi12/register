# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


time = Time.mktime(0, 0, 10, 29, 10, 2016, nil, nil, nil, 'tokyo')
25.times{
  10.times{|seat|
    Attr.create(:time => time, :status => 0, :seat => seat)
  }
  time = time + (60*12)
}

time = Time.mktime(0, 0, 10, 30, 10, 2016, nil, nil, nil, 'tokyo')
25.times{
  10.times{|seat|
    Attr.create(:time => time, :status => 0, :seat => seat)
  }
  time = time + (60*12)
}
