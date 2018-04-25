# Installation

To run this application you need at least:

* Bundler
* Ruby 2.4.1
* Rails
* Postgresql 9.3

## Prerequisites

- `$ brew install postgresql`


## Getting started

1. Checkout master branch ```git clone https://github.com/jkimmeyer/praxisprojekt.git```
2. ```cd praxisprojekt```
3. Run ```bundle```
4. Copy .env.development.sample to .env.development.
5. Copy .env.test.sample to .env.test.

If there is no database, run ```createdb``` in shell. Afterwards start the postgres console with ```psql``` and type ```createdb praxisproject_development```.

6. Run ```rake db:create:all```
7. Run ```rake db:setup```
8. Run ```rake db:migrate```
9. Run ```rake db:migrate RAILS_ENV=test```
10. Start development server ```rails s```
