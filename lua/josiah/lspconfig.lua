-- Python
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
			"python3",
			"-m",
			"pipenv",
			"run",
			"python",
			"-m",
			"pylsp"
		}
	else
		return {
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
