###Banquest

Software Engineering Large Practical project by Scott Cantisani. A small browser-based ASCII roguelike where most things are edible (and more will be in the future).

Banquest is written in Ruby 1.9.3, and uses Rails 4.1.6.

To make sure you have all the necessary gems, run 'bin/bundle install' from the root directory.
Also make sure to run migrations: 'bin/rake db:migrate ENV=development' from the root directory.

'testrb test' will run all the tests (these are in test/) when run from the root directory, but can be run from any directory. In banquest/lib/, for example, use 'testrb ../test'.

'bin/rails s' gets the server started. Access the site by typing 0.0.0.0:3000 in the address bar of a browser (this was tested on Chrome).

All game-related code is in lib/game/. HTML is in app/views/, code for the User and Run models is in app/models, and code for the controllers is in app/controllers.
Other useful places: db/ for the database schema and migrations; config/ for routes.rb.

Feedback:
I know the website design is very bare-bones (to put it kindly) and that the way saving and loading games works is very unwieldy. The web-related parts of this are those I have the least experience with: what are some more of the obvious things that could have been done better?
In terms of the game code, is it readable and are there enough comments? Are there some (obvious) design patterns I could have used to simplify the code and save myself some work?
