# drawrest

A NodeMCU app for posting pictures to a TFT frame.

## Installing

Check out https://github.com/stuartpb/spitblit to somewhere (for example, `../spitblit`), then upload the appropriate driver for your screen (minification recommended), along with the files in `src`, `vendor`, and `www`, to your ESP chip.

Using `nodemcu-tool`, from this project's root:

```sh
nodemcu-tool upload -m ../spitblit/drivers/ili9225.lua
nodemcu-tool upload src/*.lua vendor/*.lua www/*
```
