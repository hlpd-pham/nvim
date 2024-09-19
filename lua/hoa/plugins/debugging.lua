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
