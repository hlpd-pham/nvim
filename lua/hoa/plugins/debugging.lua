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
vim.keymap.set("n", "<Leader>dl", function()
	dap.step_into()
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
