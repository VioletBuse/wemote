# wemote

[![Package Version](https://img.shields.io/hexpm/v/wemote)](https://hex.pm/packages/wemote)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/wemote/)

```sh
gleam add wemote
```
```gleam
import wemote

pub fn main() {
  let remote_node = //get some remote node

  wemote.call(remote_node, fn() {1 + 2}, wemote.Infinity)
  // Ok(3)
}
```

Further documentation can be found at <https://hexdocs.pm/wemote>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam shell # Run an Erlang shell
```
