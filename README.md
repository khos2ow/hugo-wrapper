# Hugo Wrapper

The universal way to include Hugo binary to your project.

## Hugo Wrapper dependencies

`hugow` is a POSIX-style shell script which acts as a wrapper to download and run [Hugo](https://gohugo.io/)
binary - which is, in fact, [platform dependent](https://gohugo.io/getting-started/installing/#binary-cross-platform) -
for your platform. It can be executed in variety of [Operating Systems](#tested-on) and
[Command Shells](#tested-on). As a result, `hugow` has very minimal number of
dependencies:

- downloader: `wget` or `curl`
- checksum: `sha256sum` or `shasum` or `cksum`
- tarball: `tar`

## Download Hugo Wrapper

In order to use the `hugow` binary, you only need to download it and place it in the root
of your Hugo project.

```bash
curl -o hugow https://raw.githubusercontent.com/khos2ow/hugo-wrapper/master/hugow && chmod +x hugow
```

or

```bash
wget -O hugow https://raw.githubusercontent.com/khos2ow/hugo-wrapper/master/hugow && chmod +x hugow
```

## Upgrade Hugo Wrapper

In order to upgrade `hugow` binary, you can use `--upgrade` flag. The newest version of
wrapper binary will be downloaded from GitHub repository on your machine and will replace
the old one.

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

## Hugo Wrapper flags

`hugow` supports the following flags and passes through any additional flag directly to
Hugo binary itself.

```text
Flags:
      --get-latest                 get latest version of hugo binary.
      --get-version string         get specified version of hugo binary.
      --upgrade                    upgrade hugo wrapper binary itself.
  -h, --help                       help for hugo-wrapper

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

 Operating Systems | Architecture | bash | sh | csh | tcsh | zsh | ksh | PowerShell |
-------------------|--------------|------|----|-----|------|-----|-----|------------|
 DragonFloyBSD     | amd64        | -    | -  | -   | -    | -   | -   | -          |
 FreeBSD           | i386         | -    | -  | -   | -    | -   | -   | -          |
 FreeBSD           | amd64        | -    | -  | -   | -    | -   | -   | -          |
 FreeBSD           | ARM          | -    | -  | -   | -    | -   | -   | -          |
 Linux             | x86          | -    | -  | -   | -    | -   | -   | -          |
 Linux             | x86_64       | ✔    | ✔  | -   | -    | -   | -   | -          |
 Linux             | ARM          | -    | -  | -   | -    | -   | -   | -          |
 Linux             | ARM64        | -    | -  | -   | -    | -   | -   | -          |
 macOS             | x86          | -    | -  | -   | -    | -   | -   | -          |
 macOS             | x86_64       | -    | -  | -   | -    | -   | -   | -          |
 macOS             | ARM          | -    | -  | -   | -    | -   | -   | -          |
 macOS             | ARM64        | -    | -  | -   | -    | -   | -   | -          |
 NetBSD            | i386         | -    | -  | -   | -    | -   | -   | -          |
 NetBSD            | amd64        | -    | -  | -   | -    | -   | ✔   | -          |
 NetBSD            | ARM          | -    | -  | -   | -    | -   | -   | -          |
 OpenBSD           | i386         | -    | -  | -   | -    | -   | -   | -          |
 OpenBSD           | amd64        | -    | -  | -   | -    | -   | -   | -          |

## License

Licensed under [Apache License version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
Please see the [LICENSE](https://github.com/khos2ow/hugo-wrapper/blob/master/LICENSE)
file included in the root directory of the source tree for extended license details.
