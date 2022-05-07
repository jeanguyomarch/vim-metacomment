# vim-metacomment

## What does this thing do?

Basically, type `:MetaComment Blah blah, some text`, this inserts in your
buffer a boxed comment that looks like this, starting at the position of your
cursor:

```
//============================================================================//
//                            Blah blah, some text                            //
//============================================================================//
```

## Installation

With [vim-plug][1], add the following line to your vim/neovim configuration
file:

```
Plug 'jeanguyomarch/vim-metacomment'
```

## Usage

In a nutshell, just use `:MetaComment <text>`. See the documentation (i.e.,
`:help vim-metacomment`) for details.

## Limitations

* The comment box is ill-formed if the cursor is not in the first column.
* The comment box does not support multi-line text.
* The size of the comment box is fixed.

## License

See [`LICENSE.md`](LICENSE.md).

[1]: https://github.com/junegunn/vim-plug
