# impl: What's the implementation of a Ruby method?

## Usage

    $ cd ~/git/ruby193
    $ ctags -R
    $ impl >> tags

After moving into the latest Ruby source code directory of you, the first command builds `tags` by the Ruby C source codes, using your own `ctags` command. Then impl extracts Ruby methods both from the source codes and the `tags` file. The command outputs additional tags to STDOUT, so you may want to redirect to `tags` for appending them.

Now you can go into the definition of a Ruby method by Ruby method format like `Random#rand`!

Higher level handy command is also available. The following command does almost equivalent to the three command previously I showed.

    $ impl --suite ~/git/ruby193

## Install

    $ gem install impl

## Author

Tatsuhiro Ujihisa

## Trivia

`tags` is an all left handed word. `impl` is an all right handed word. If you are a dvorak user, you can type them easily.
