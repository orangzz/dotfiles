<br />
<samp align="center">
  <p>
    <a href="#">
      <img src="./public/folder.svg" alt="Logo" height="40">
    </a>
  </p>
  <h3 align="center">Setup Config</h3>
</samp>

**[<kbd> <br> Install <br> </kbd>][Install]** 
**[<kbd> <br> Usage Instruction <br> </kbd>][Quick Start]** 
**[<kbd> <br> Configure <br> </kbd>][Configure]**

> 用的上的工具才叫工具，用不上的只是数字安慰剂

documented changelog, forum, wiki,

feedback chat, calendar,ticket

opinionated, sensible, decent defaults

backup, migrate and restore execution environments
sync config with remote(ssh teleported)

## Winodw tiling manager

hyberland
Aerospace
shkd
Synology NAS

## vscode: zen mode setup

zen mode: minimal ui, distraction
productivity lab

## Shell setup

> battery-included, out-of-box, opinionated, sensible defaults

systemd completions

operating system's process manager

- startup time profiling/benchmark
  - broot, zxoide directory tree navigation
  - fzf takeover tab complete and history naviagtion, fuzzy search, directory entry, file content thumbnail
  - syntax highlighting
  - auto suggestion
  - command prompt
  - session,job,screen
  - window tilde manager and terminal multiplexer tmux,zellij
  - teleport shell environment, history to remote host when connecting over ssh.
  - lualine word count, estimated read time
  - cluster management, container management
  - shows the floating completion suggestion panel as you type

shell startup time benchmark

```bash
time /bin/zsh -i -c exit
```

fish - tab subcommand/option completion, syntax highlighting, work out of box

- starup file
- prompt themeo
- nerd font

rc file and profile file
`.zprofile`, any expensive shell settings only needs initialized once at login,

when bash invoked as login shell: load `.bash_profile`
when bash invoked as interactiveshell: load `.bashrc`
sourcing `.bashrc` into `.bash_profile` to keep things working in all the scenarios

`.zshrc` or `.zprofile`

take inspiration from symbol link farm manager

### shell scripts

shellbang line: which interpreter should be used to execute them
share your script, use env to allow for the interpreter to be installed in other locations
The shebang line is only used when scripts are executed without specifying the interpreter.

## devContainer

setup runtime environment

- app sandbox
- lang interpeter, complier, packager manager, lsp
- database

## roadmap

## project kanban

## 大模型接入

dump historical baggage

if it ain’t broke, don’t fix it”

restore, replicate the syteem preferences and application settings under Arch Linux and Macos

backup,sync

organize as snippet
`conf.d`
`paths.d`

- link:
  ~/.tmux.conf:
  path: .tmux.conf
  ~/.gitconfig:
  path: .gitconfig # Take all of the files and directories in .config dir of this repo, # and link them to the target system # at ~/.config.
  ~/.config/:
  glob: true
  path: .config/\*
  ~/.gnupg/gpg-agent.conf:
  path: gpg-agent.conf
  ~/.ansible.cfg:
  path: .ansible.cfg # This is the neat part: dotbot configuration manages Mackup configuration.
  ~/.mackup.cfg:
  path: .mackup.cfg # These two launchctl agents are only required on Mac OS # to make gpg-agent play nice with ssh auth in apps that don't start # from shell with it's environment.
  ~/Library/LaunchAgents/homebrew.gpg.gpg-agent.plist:
  path: Library/LaunchAgents/homebrew.gpg.gpg-agent.plist
  ~/Library/LaunchAgents/link-ssh-auth-sock.plist:
  path: Library/LaunchAgents/link-ssh-auth-sock.plist
  source of inspiration

## Terminal emulator

color-theme
font
image preview

rxvt
xterm

## how we organize dotfiles

# Keep shell config clean and stop polluting `$HOME` directory

## file manager in shell

## App launcher

raycast

## tmux

- tmux
- zellij
  floating panel: toggle a pane floating on top of everything else—I often use this for Lazygit.

## Git setup

- [lazygit]()
- gitkarden
- [magit](https://magit.vc)

## Text editor/IDE setup

- [helix](https://helix-editor.com)
  - LSP (including autocompletion, show signature, go to definition, show references, etc.) just works
  - Tree-sitter is built in, you can even do selections on tree-sitter objects
  - A file picker and global search
  - Pressing a key in normal mode shows subsequent keys you can press, and what they do
  - You can jump to any visible word, add/remove/replace quotes or other characters
- nvim
  - [astronvim]()
  - [nvchad]()

### nvim

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
.aerospace.autocomplete
.ansible.cfg
```

## devContainer

Patterns of Enterprise Application Architecture and Refactoring.

capturing established practices and promoting practices that are not yet widely used

include your judgment cal

### codebase version control

### lanauage runtime,package release and dependency manager installed

system packages
scope to project containing the app
dependency declaration manifest
pip is used for declaration and virtualenv for isolation.

### Store App deploy config in environment

credentails/locator to external service such amazon s3

### Back service intergration

third party/external/attached services.

datastore service(such as mysql, or CouchDB, influxdb),
messaging/queueing systems (such as RabbitMQ)
mail service (such as Postfix),
assets/content service(amazon s3, cloudflare r2)
pay service layer(alipay, wechatpay)
and caching systems (upstash, redis).
map service
metric gathering service
[music discorvery service](https://www.last.fm/api)

### Build, release, run

Build: transform a codebase into an executable bundle
release:
run: runs the app in the execution environment, run at-scale
run as daemon, managed by process manager,run when the operating system starts up, and should be restarted if the process crashes for any reason.

deploy: process binding to a port and awaiting incoming requests

### admin-process

A process type is the prototype from which one or more processes are instantiated
a class is the prototype from which one or more objects are instantiated in object-oriented programming.

one-off task, such as a database migration
scheduled jobs such as database backup
worker process

continouse deployment
live edits to a local deploy
distrutbuited deploy accessed by end users.

after ship
云服务
基于云的文件存储架构
数据存储 块存储，对象存储（oss）api 访问，文件存储（nas）挂载访问
数据迁移和同步 localfs， networkfs syntchning， sever meessaging block（smb）
备份：归档存储，快照
备份策略

日志存储
容器镜像，私人网盘（共享卷），代码库
函数计算

挂载点管理
挂载点是计算节点（ECS 实例、函数计算或容器服务）访问文件系统的入口。挂载点定义了什么类型网络的计算节点，采用怎样的权限来访问文件系统。同一个挂载点可以被多个计算节点同时挂载，共享访问。
地域，可用区，专有网络 vpc
sudo yum install nfs-utils
sudo apt-get install nfs-common

n8n 部署 aigent，
内容分发（cdn）
域名解析
邮件解析
