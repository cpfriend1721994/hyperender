# Hyperender

HATEOAS-like rendering layout for Rails Applications

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hyperender'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hyperender

## Usage

Add this line to your application's controller:

```ruby
include Hyperender::Action
```

All of the functions below support a variety of functions independent on the arguments passed to it:

```ruby
hateoas_data *args		# add data for rendering
hateoas_error *args		# add error for rendering
hateoas_params *args	# add parameters for rendering
```

And without arguments passed, return variables:

```ruby
hateoas_data			# return data
hateoas_error			# return error
hateoas_params			# return parameters
hateoas_message			# return message
hateoas_status			# return status
hateoas_request			# return request
hateoas_render			# return the HATEOAS-like JSON value
```

To render HATEOAS-like JSON value:

```ruby
hateoas_rendering 		# render json: hateoas_render
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on Edumall Gitlab at https://git.edumall.io/minhtu/hyperender. This project is intended with all TST Team to be a safe, welcoming space for collaboration, and contributors.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).