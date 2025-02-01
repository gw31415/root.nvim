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

## License

MIT License
