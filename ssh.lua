local M = {}

function M.options(config)
	config.ssh_domains = {
		{
			name = "thob_alpha",
			remote_address = "68.183.89.231",
			multiplexing = "None",
		},
	}
end

return M
