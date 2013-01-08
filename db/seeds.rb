# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

statuses = Status.create([{:value => 'outage'},
                          {:value => 'slow'},
                          {:value => 'error'},
                          {:value => 'restart'}])
            
users = User.create([{:username => "james", :password => "rasputin"}])

services = Service.create([{:name => "cagetcare"},
                           {:name => "sfgetcare"},
                           {:name => "msgetcare"}])
            