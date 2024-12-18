local dap, dapui = require("dap"), require("dapui")
dapui.setup()

vim.keymap.set("n", "<Leader>dt", function()
	dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>ds", function()
	dap.set_breakpoint()
end)
vim.keymap.set("n", "<Leader>dc", function()
	dap.continue()
end)
vim.keymap.set("n", "<Leader>d0", function()
	dap.step_out()
end)
vim.keymap.set("n", "<Leader>do", function()
	dap.step_over()
end)

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- golang debug
local dap_go = require("dap-go")
dap_go.setup({
	dap_configurations = {
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
	delve = {
		path = "dlv",
		initialize_timeout_sec = 20,
		port = "${port}",
		args = {},
		build_flags = {},
		detached = vim.fn.has("win32") == 0,
		cwd = nil,
	},
	tests = {
		verbose = false,
	},
})

-- js debug
require("dap-vscode-js").setup({
	node_path = "node",
	debugger_path = "/Users/hoapham/workspace/vscode-js-debug",
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

local workspace_folder = os.getenv("HOME") .. "/workspace/statsig/scrapi"

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			runtimeExecutable = "node",
			runtimeArgs = {
				workspace_folder .. "/node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = workspace_folder,
			cwd = workspace_folder,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}
end
