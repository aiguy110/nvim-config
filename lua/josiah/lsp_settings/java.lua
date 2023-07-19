require'lspconfig'.jdtls.setup{
    cmd = {'docker', 'run', '--pid=host', '-i', '-v', vim.fn.getcwd() .. ':' .. vim.fn.getcwd(), '-v', os.getenv('HOME') .. '/.m2:/root/.m2', 'kaylebor/eclipse.jdt.ls:v0.60.0'}
}

-- local lfs require 'lfs'
-- local config = {
--     cmd = {'docker', 'run', '-it', '-v', lfs.currentdir() .. ':/eclipse-workspace', 'kaylebor/eclipse.jdt.ls:v0.60.0'},
--     root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
-- }
-- require('jdtls').start_or_attach(config)
