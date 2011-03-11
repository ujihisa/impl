# impl: What's the implementation of a Ruby method?

## Usage

### Impl normal usage

    $ impl ~/git/ruby193 'Strimg#sum'
    String#sum	string.c	/^rb_str_sum(int argc, VALUE *argv, VALUE str)$/;"	f	file:

This may take long time in the first time you called, but it won't take time in the next time.

## Impl plumbing usage (mostly for editor integration)

    $ cd ~/git/ruby193
    $ ctags -R
    $ impl --create . >> tags

After moving into the latest Ruby source code directory of you, the first command builds `tags` by the Ruby C source codes, using your own `ctags` command. Then impl extracts Ruby methods both from the source codes and the `tags` file. The command outputs additional tags to STDOUT, so you may want to redirect to `tags` for appending them.

Now you can go into the definition of a Ruby method by Ruby method format like `Random#rand`!

## Legacy usage (not available right now)

Higher level handy command is also available. The following command does almost equivalent to the three command previously I showed.

    $ impl --suite ~/git/ruby193

## Install

    $ gem install impl

## Author

Tatsuhiro Ujihisa

## Trivia

`tags` is an all left handed word. `impl` is an all right handed word. If you are a dvorak user, you can type them easily.
