# PostcodeValidation

This gem provides basic postcode validation functionality which can be used in any application
 
It also comes with out of the box plugins for:

- Solidus

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postcode_validation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install postcode_validation

## Usage

### Using with Solidus

```ruby
require 'postcode_validation'
require 'postcode_validation/plugins/solidus'
Spree::Order.include(PostcodeValidation::SpreeOrderPostcodeValid)
````

NB: Error reporting currently only works with a Tagged Logger

### Bespoke application usage

```ruby
require 'postcode_validation'
use_case = PostcodeValidation::UseCase::ValidateAddress.new(
  address_match_gateway: PostcodeValidation::Gateway::PCAPotentialAddressMatch.new
)

valid = use_case.execute(postcode: 'SE10SW', country: 'GB')[:valid?]
```

```
> valid
true
```

Country must be a valid 2-letter ISO country code.
Postcode is the postcode under test.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/madetech/postcode_validation.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

##Credits

Developed and maintained by [Made](http://www.madetech.co.uk?ref=github&repo=postcode_validation).

[![made](https://s3-eu-west-1.amazonaws.com/made-assets/googleapps/google-apps.png)](http://www.madetech.co.uk?ref=github&repo=postcode_validation)

Key contributions:

* [Craig J. Bass](https://github.com/craigjbass)
* [Seb Ashton](https://github.com/sebashton)
