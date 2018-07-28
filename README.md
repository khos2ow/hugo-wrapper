# Hugo Wrapper

The universal way to include Hugo binary to your project.

## Download Hugo Wrapper

In order to use the `hugow` binary, you only need to download it and place it in the root of your Hugo project.

```bash
curl -o hugow https://raw.githubusercontent.com/khos2ow/hugo-wrapper/master/hugow && chmod +x hugow
```

or

```bash
wget -O hugow https://raw.githubusercontent.com/khos2ow/hugo-wrapper/master/hugow && chmod +x hugow
```

## Upgrade Hugo Wrapper

In order to upgrade `hugow` binary, you can use `--upgrade` flag. The newest version of wrapper binary will be
downloaded from GitHub repository on your machine and will replace the old one.

```bash
./hugow --upgrade
```

## Hugo Wrapper usage

and use it the same way you'd use Hugo binary itself:

```bash
./hugow          # to build the site
./hugow server   # to start the server
./hugow --help   # to show help of both Hugo and Hugo Wrapper
```

On the first execution, `hugow` downloads the _latest_ Hugo binary from
[official releases](https://github.com/gohugoio/hugo/releases) and caches it locally as
`<PROJECT_ROOT>/.hugo/hugo` and also keeps track of the downloaded version in
`<PROJECT_ROOT>/.hugo/version`. As a result from the second execution forward it will only
execute the - already downloaded - binary.

## Download specific Hugo version

With `hugow` you can download `LATEST` or specific version of Hugo binary, and you can
upgrade or downgrade at any given time.

```bash
./hugow --get-latest                    # to get latest Hugo version
./hugow --get-version <VERSION_NUMBER>  # to get specific Hugo version
```

## Content of `.gitignore`

`.hugo` folder in `PROJECT_ROOT` which contains downloaded Hugo binary and the `version`
should be added to `.gitignore`. Note that this is usually good enough, and it makes
your user to easily access Hugo binary without needing to actually go and download
specific version based on their OS and CPU architecture.

example `.gitignore` content:

```gitignore
.hugo
```

But if you need a fine grained control of which version of Hugo is intended to be used
for your project, or if you need an absolute fixed version of Hugo to be used everywhere
(on users machine, CI job container, etc) you need to check in the `.hugo/version` into
your project repository as well to ensure consistence Hugo version everywhere.

example `.gitignore` content:

```gitignore
.hugo/*
!.hugo/version
```

## Tested on

- Ubuntu 18.04, x86_64
- Ubuntu 17.10, x86_64
- Debian 9.5, x86_64
- Mac OS X (TODO)

## License

Licensed under [Apache License version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
Please see the [LICENSE](https://github.com/khos2ow/hugo-wrapper/blob/master/LICENSE)
file included in the root directory of the source tree for extended license details.
