# Yaml2csv

Convert yaml file to csv format string.
** Array is supported! **

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yaml2csv', github: "odawara-100ren/yaml2csv"
```

And then execute:

```
$ bundle
```

Or you can install it by yourself.
[`specific_install`](https://github.com/rdp/specific_install) gem is needed for gem install.

```
$ gem install specific_install
$ gem specific_install -l "https://github.com/odawara-100ren/yaml2csv"
```

## Usage

```
$ yaml2csv --file examples/example.yml
```

### Example

```
$ yaml2csv --file examples/example.yml
path1,path1,path1,path1,path1,path1,path2
path11,path11,path12,path13,path13,path13,key2a
key11a,key11b,path121,value13_1,value13_2,value13_3,value2a
value11a,value11b,key121a,,,,
,,value121a,,,,
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yaml2csv. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yaml2csv project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yaml2csv/blob/master/CODE_OF_CONDUCT.md).
