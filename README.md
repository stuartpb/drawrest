# postftr

A NodeMCU app for posting pictures to a TFT frame.

## Installing

Check out https://github.com/stuartpb/spitblit to somewhere (for example, `../spitblit`), then upload its drivers, along with the files in `src` and `vendor`, to your ESP chip.

Using `nodemcu-tool`, from this project's root:

```sh
nodemcu-tool upload ../spitblit/drivers/*.lua src/*.lua vendor/*.lua
```
