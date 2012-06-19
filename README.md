# ActsAsContextual

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'acts_as_contextual'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_contextual

## Usage
```ruby
class ThingWhichContextualize << ActiveRecord::Base
  acts_as_contextualizer
end

class ThingToContextualize << ActiveRecord::Base
  acts_as_contextual  :allow_contextualisation => true
end

//config/initializers/acts_as_contextual.rb
ActsAsContextual.configure do |config|
  config.current_context = ThingWhichContextualize.first // or whatever you want
end
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
