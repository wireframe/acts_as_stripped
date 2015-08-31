# acts_as_stripped

> Simple utility to strip whitespace from string model attributes.

## Installation

Bundler configuration:
```ruby
gem 'acts_as_stripped'
```

## Usage

```ruby
# strip whitespace from specified string attributes
class Post < ActiveRecord::Base
  acts_as_stripped :title, :summary
end
```

## Copyright

Copyright (c) 2009 Ryan Sonnek. See LICENSE for details.
