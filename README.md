# Codex

A Crystal library for writing text-based games.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     codex:
       github: mzyzc/codex
   ```

2. Run `shards install`

## Usage

```crystal
require "codex"

game = Codex::Game.new("Game Title")
```

Initialize a `game` object and use it to create scenes and choices for the player.

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/mzyzc/codex/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [mzyzc](https://github.com/your-github-user) - creator and maintainer
