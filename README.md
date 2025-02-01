# root.nvim

Just cd to project-root.

## Features

- **Automatic Project Root Detection:**  
  Walks up the directory tree from the target file until it finds one of the following markers:
  - **Directories:** `.git`, `.svn`, `.hg`, `.bzr`
  - **Files:** `.gitignore`, `Rakefile`, `pom.xml`, `project.clj`, `package.json`, `manifest.json`
  - **Patterns:** `*.csproj`, `*.sln`

## Installation

Use your favorite plugin manager. For example:

### Using packer.nvim

```lua
use 'gw31415/root.nvim'
```

### Using vim-plug

```lua
Plug 'gw31415/root.nvim'
```

Then, restart Neovim and install the plugin with your plugin manager’s install command (e.g., :PackerSync or :PlugInstall).

## Usage

```lua
require 'root'.cd('path/to/file.ext') -- Jump to the Project-Root of the file
require 'root'.cd()                   -- Current editing file
require 'root'.cd(nil, true)          -- Quietly
```

## Tips

`:Root` command is useful by passing options on startup.

First, define `:Root` command in your `init.lua` to make it callable at startup.

```lua
-- Timer hack to suppress noisy messages on startup
local quiet = true
vim.defer_fn(function()
	quiet = false
end, 20)

vim.api.nvim_create_user_command('Root', function(opts)
	require 'root'.cd(opts.args, quiet)
end, {
	nargs = '?',
	complete = 'file',
})

```

Then, you can pass it as an option when launching nvim:

```bash
nvim path/to/file.ext +Root
```

## License

MIT License
