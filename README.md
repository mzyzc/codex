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

game.add_scene(
  "start",
  text: "Win or lose?",
  choices: ["win", "lose"],
)

game.add_choice(
  "win",
  text: "You won!",
  trigger: ->(text : String) { return text.includes?("win") },
  next_scene: nil,
)

game.add_choice(
  "lose",
  text: "The spider keeps moving",
  trigger: ->(text : String) { return text.includes?("lose") },
  next_scene: "start",
)

game.run("start")
```

Initialize a `game` object and use it to create scenes and choices for the player.

## Contributing

### Github

1. Fork it (<https://github.com/mzyzc/codex/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Sourcehut

1. Clone repository
2. Make and commit your changes
3. Send the commits as a patch to one of the maintainers below using
	git send-email. see [this](https://git-send-email.io/) for a guide.

## Contributors

- [mzyzc](https://github.com/mzyzc) - creator and maintainer
