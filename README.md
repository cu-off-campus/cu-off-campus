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

## Links

- Github: https://github.com/cu-off-campus/cu-off-campus
- Heroku: https://glacial-sea-27301.herokuapp.com

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

> Currently, database should be populated every time the test is run. Will change in later versions. 

For `rspec` tests, run

```
bundle exec rspec spec
```

For `cucumber` tests, run

```
bundle exec cucumber features
```

The coverage report is in `coverage/` directory.
