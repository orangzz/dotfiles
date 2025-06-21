## devContainer

app sandbox

## nvim
`mason`: lanaguage-sever autocomplete
`mason-lspconfig` - lanauge compiler,interpreter and runtime and package manager
(complier language file into executable in lanaguage runtime)
(opt involved packaging/bunlde,collect a set of class files into a jar file )

(
/java jdk(javac comiple,jar packaging/bundle, java runtime)
luarocks/lua,
npm/node runtime, 
pip/python interpreter, 
built-in go mode/go compiler, 
cargo/rust
)
`nvim-treesitter` - syntax-hightlighting
`nvimtree` - file explorer
`nvim-linter` - create auto command to run the linter when opening a buffer, saving or leaving insert mode
`telescrope`: telescope nvchad theme selector
```bash
# check file type of buffer
:echo &filetype
# check loaded treesitter languages
:lua print(require"nvim-treesitter.parsers".get_buf_lang())
# set file type
:set filetype=bash
```


```bash
# check file type

# list treesitter installed languages
:TSInstallInfo
# install fish for treesitter
:TSInstall fish
# update fish
:TSUpdate fish
# update all
:TSUpdate
:TSDisable highlight
:TSEnable highlightch
```
```bash
# check defualt args 
:lua print(vim.inspect(require('lint').linters.luacheck.args))
# overwrite the arguments table for luacheck

```

```bash
:checkhealth masongg

```
