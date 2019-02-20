
### Live demo
Live demo on => [heroku](https://rocky-scrubland-46590.herokuapp.com/questions)

## Getting Started
+ Clone the application with `git clone https://github.com/gersosa/tpi-Ruby.git

## Dependencies

* Ruby version 2.5.1 and above
* Rails 2.5.1
* PostgreSQL

### Downloading PostgreSQL
Run these commands from terminal:

`sudo apt updatee`

`sudo apt install postgresql postgresql-contrib`

Them:
`sudo -i -u postgres`

Create database : `createdb Example`

Create role:`psql` and `create role myapp with createdb login password 'password1';`

* Run `bundle install` to install all other dependencies

* Run  `rake db:migrate` 


*If Can't install pg gem:

`sudo apt-get install libpq-dev`
## Running The Server

You can then run `rails s` or `rails server` and visit the page on the browser by typing `localhost:3000`. (*you can add the flag `-p <port_number>` to specify a different port number, e.i. `rails s -p 8000`*)

## Running Tests
You can then run:
* `rspec spec/controllers/user_controller_controller_spec.rb`
* `rspec spec/controllers/answer_controller_controller_spec.rb`
* `rspec spec/controllers/question_controller_controller_spec.rb`



## Application Main Features

* Write a question
* Answer to questions
* Delete questions/answers if you're the owner
* Register with username and password
* log in/log out
* authenticate