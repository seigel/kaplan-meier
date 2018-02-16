# KaplanMeier

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/kaplan_meier`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

This current intent of this library is to support doing a Kaplan-Meier Survival Analysis and generating survival plots for subjects that have a brain tumour diagnosis.  This is in support of research being conducted to help create better treatments and improve outcomes.

This does not mean it is only useful for that, but it is the initial driver of the interface for better or for worse.

Please dive in and suggest changes through issues and pull requests.  The latter getting more attention.

I will be using a couple of sites to validate the approach.  The current two sources I am using as truth are:

* [Example from graphpad](https://s3.amazonaws.com/cdn.graphpad.com/faq/1757/file/P4-Survival%20analysis.pdf) 
* [Survival Analysis From Stats Direct](https://statsdirect.com/help/survival_analysis/kaplan.htm)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kaplan_meier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kaplan_meier

## Usage

TODO: Improve these but taking the example data and results from graphpad, here is the current way it would be used.

```ruby
 # At some point I will try and generate decent docs.  If you look at the code
 # it is using named parameters.
  

km = KaplanMeier.new
km.add(46, 1, 1)
km.add(64, 0, 1)
km.add(78)
km.add(124)
km.add(130, 0, 1)
km.add(150, 0, 2)

km.raw_probabilities
km.raw_probabilities(as_percent: true)
km.probabilities
km.probabilities(as_percent: true)

km.range 
km.values_for_range
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/seigel/kaplan_meier.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
