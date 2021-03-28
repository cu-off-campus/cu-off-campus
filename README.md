# CU Off Campus

CU Off-Campus is an apartment search platform created exclusively for Columbia students.

## Team Members

- Allen Song (zs2510)
- Leo Qian (yq2292)
- Yiwen Fang (yf2560)

## Iterations

### Iteration 1

- Tag: `proj-iter1`
- Branch: `iter-1-blocker`
- Heroku: https://glacial-sea-27301.herokuapp.com

### Iteration 2

- Heroku: https://fierce-ravine-62859.herokuapp.com

## Links

- Github: https://github.com/cu-off-campus/cu-off-campus

## Main Features

- Apartment listing with sorting and searching functionalities
- Edit and create apartment information

## Instructions

Install `ruby 2.7.2`. Also, install bundle with `gem install bundle`.

The project uses PostgreSQL as the database, so PostgreSQL environment should be ready.

Then, install the required packages with `bundle install`:
```
bundle install
```

Setup the database:
```
bundle exec rake db:setup
```

### Starting the server

```
bundle exec rails server -b 0.0.0.0
```

### Run the tests

For `rspec` tests, run

```
bundle exec rake db:drop RAILS_ENV=test
bundle exec rake db:setup RAILS_ENV=test
bundle exec rspec spec
```

#### Cucumber

> Database should be empty before the test is run. 

For `cucumber` tests, run

```
bundle exec rake db:drop RAILS_ENV=test
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:migrate RAILS_ENV=test
bundle exec cucumber features
```

#### Coverage

After running all the above tests, the coverage report is generated in the `coverage/` directory.
