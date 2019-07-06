# crystal-pdf

The primary purpose of `crystal-pdf` is to provide rendering layer for `caramel`.
It wraps `crystal-pdflib` for ease of use and to add higher-level functionality.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     pdf:
       github: rowland/crystal-pdf
   ```

2. Run `shards install`

## Usage

```crystal
require "pdf"
```

The module is called `PDF`, without any "crystal" prefix.

## Development

Functionality will be added as-needed by `caramel`.

## Contributing

1. Fork it (<https://github.com/rowland/crystal-pdf/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Brent Rowland](https://github.com/rowland) - creator and maintainer
