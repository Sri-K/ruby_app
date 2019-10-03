## Smart Pension Test

# Rubyapp to parse the logs

A simple Ruby script that parses a webserver log.

### Install Requirements

- `gem install bundler`
- `bundle install`
- `ruby ./bin/parser.rb webserver.log`

### Tests

Used RSpec to describe the behaviour of the parser with a few examples. Used a few lines from the webserver.log file for testing purposes.

`bundle exec rspec spec/lib/log_parser_spec.rb`
