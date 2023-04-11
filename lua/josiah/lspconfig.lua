-- Python
-- Find the python command to use
local function is_command_executable(command)
	local handle = io.popen("command -v " .. command)
	local result = handle:read("*a")
	handle:close()

	return result ~= ""
end

local check_cmds = {
	"python3",
	"/opt/pypy3.9/bin/pypy"
}

local python_cmd = "python"

for _, cmd in ipairs(check_cmds) do
	if is_command_executable(cmd) then
		python_cmd = cmd
		break
	end
end

-- Check if Pipfile is present in root_dir
local function has_pipfile(root_dir)
	local handle = io.open(root_dir .. "/Pipfile", "r")
	if handle ~= nil then
		io.close(handle)
		return true
	else
		return false
	end
end

-- Use pipenv virtualenv for pylsp if Pipfile is present
local function get_pylsp_cmd(root_dir)
	if has_pipfile(root_dir) then
		return {
			python_cmd,
			"-m",
			"pipenv",
			"run",
			"python",
			"-m",
			"pylsp"
		}
	else
		return {
			python_cmd,
			"-m",
			"pylsp"
		}
	end
end

-- Do configuration
require 'lspconfig'.pylsp.setup {
	cmd = get_pylsp_cmd(vim.fn.getcwd()),
	settings = {
		pylsp = {
			plugins = {
				pylint = {
					enabled = true,
					executable = "pylint"
				}
			}
		}
	}
}


-- Lua
require 'lspconfig'.lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
}
