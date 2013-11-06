# Irxrb

[![Build Status](https://secure.travis-ci.org/irxground/irxrb.png?branch=master)](http://travis-ci.org/irxground/irxrb)

This gem extends ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'irxrb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install irxrb

## Usage

- [Type Parameter](spec/generic_type_spec.rb)
    - Enable to create generic class like Java.
- [Hash Object](spec/hash_object_spec.rb)
    with [`core_ext`](spec/core_ext/hash_to_obj_spec.rb)
    - Create singleton object from hash.
- [Lazy Attribute](spec/lazy_attribute_spec.rb)
    - Initialize object field lazily.
- [Range to Regexp](spec/range_to_regexp_spec.rb)
    with [`core_ext`](spec/core_ext/range_to_regexp_spec.rb)
    - Convert range to regular expression pattern.
- MatchData to Hash [`core_ext`](spec/core_ext/match_data_to_hash_spec.rb)
    - Add `to_hash` method `MatchData`
- Object to Proc [`core_ext`](spec/core_ext/to_proc_spec.rb)
    - Add `to_proc` method to Object to use `&` operator

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
