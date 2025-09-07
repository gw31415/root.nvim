local function is_project_root(dir)
	local markers = { '.git', '.svn', '.hg', '.bzr', 'Rakefile', 'pom.xml', 'project.clj', 'package.json',
		'manifest.json' }
	for _, marker in ipairs(markers) do
		local path = dir .. '/' .. marker
		if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
			return true
		end
	end
	if vim.fn.glob(dir .. '/*.csproj') ~= '' or vim.fn.glob(dir .. '/*.sln') ~= '' then
		return true
	end
	return false
end

local function find_project_root(start_dir)
	local dir = start_dir or vim.fn.expand '%:p:h'
	while dir ~= '/' do
		if is_project_root(dir) then
			return dir
		end
		local parent = vim.fn.fnamemodify(dir, ':h')
		if parent == dir then break end
		dir = parent
	end
	return nil
end

return {
	cd = function(target_file, quiet)
		if target_file == '' or target_file == nil then
			target_file = vim.fn.expand '%:p'
		else
			if vim.fn.filereadable(target_file) == 0 then
				if not quiet then
					vim.notify('File does not exist', vim.log.levels.ERROR)
				end
				return
			end
			target_file = vim.fn.fnamemodify(target_file, ':p')
		end
		local start_dir = vim.fn.fnamemodify(target_file, ':h')
		local root = find_project_root(start_dir)
		if root then
			local cmd = vim.g.root_cd_cmd or 'tcd'
			vim.cmd(cmd .. ' ' .. vim.fn.fnameescape(root))
			if not quiet then
				vim.notify('Changed directory to ' .. root)
			end
		else
			if not quiet then
				vim.notify('Project root not found', vim.log.levels.ERROR)
			end
		end
	end,
	find_project_root = find_project_root,
}
