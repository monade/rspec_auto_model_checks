![Tests](https://github.com/monade/rspec_auto_model_checks/actions/workflows/test.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/rspec_auto_model_checks.svg)](https://badge.fury.io/rb/rspec_auto_model_checks)

# RSpec Auto-model checks
A gem that provides a set of RSpec matchers to automatically check model validations and associations.

** Gem in development, DON'T USE IT **

## Installation

```ruby
gem 'rspec_auto_model_checks', github: 'monade/rspec_auto_model_checks'
```

## Usage and Examples

Add check_validations! and/or validate_associations! to your model test

```ruby
  RSpec.describe Order, type: :model do
  check_validations!
  validate_associations!
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

About Monade
----------------

![monade](https://monade.io/wp-content/uploads/2023/02/logo-monade.svg)

active_queryable is maintained by [mònade srl](https://monade.io).

We <3 open source software. [Contact us](https://monade.io) for your next project!
