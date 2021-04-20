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

- Tag: `proj-iter2`
- Branch: `iter-2-blocker`
- Heroku: https://fierce-ravine-62859.herokuapp.com

### Launch

- Tag: `proj-launch`
- Branch: `launch-blocker`
- Heroku: https://infinite-crag-74624.herokuapp.com/

Progress based on the TA’s grading comments of proj-iter2

1. **Comment: Sort by should have the option to go ascending or descending**

   Sorting of both ascending and descending is added.

2. **Comment: More functionality in search could be useful**

   Search can now search apartments, comment descriptions, and comment tags, instead of only apartments in proj-iter2.

3. **Comment: Sorts should happen automatically, without having to click Filter.**

   Sorting takes effect immediately when making a selection, not need to click Filter button any more.

## Links

- Github: https://github.com/cu-off-campus/cu-off-campus

## Main Features

- Apartment listing with sorting and searching functionalities
- Edit and create apartment information
- Comments with tags
- User registration, log in and log out functionalities

## Instructions

### Database Preparation

The project uses PostgreSQL as the database, so PostgreSQL environment should be ready. There should be a user `cuoc` with the password `cuoc` configured (for development environment and test environment).

### Running with Rails

Install `ruby 2.7.2`. Also, install bundle with `gem install bundle`.

Then, install the required packages with `bundle install`:
```
bundle install
```

Setup the database:
```
bundle exec rake db:setup
```

Then start the server.

```
bundle exec rails server -b 0.0.0.0
```

### Runing the tests

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
