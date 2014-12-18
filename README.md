###Banquest

Software Engineering Large Practical project by Scott Cantisani. A small browser-based ASCII roguelike where most things are edible (and more will be in the future).

Banquest is written in Ruby 1.9.3, and uses Rails 4.1.6.

To make sure you have all the necessary gems, run 'bin/bundle install' from the root directory.
Also make sure to run migrations: 'bin/rake db:migrate ENV=development' from the root directory.

'testrb test' will run all the tests in the test/ directory when run from the root directory, but can be run from any directory. In banquest/lib/, for example, use 'testrb ../test'.