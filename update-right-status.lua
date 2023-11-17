local M = {}

function M.init(wezterm, terminal)
	wezterm.on("update-right-status", function(window, pane)
		local cells = {}
		local key_mode = window:active_key_table()
		local mode = {
			["search_mode"] = "󰜏",
			["copy_mode"] = "",
		}
		if not key_mode then
			table.insert(cells, "")
		else
			table.insert(cells, mode[key_mode])
		end
		--
		local workspace = window:active_workspace()
		if workspace == "default" then
			workspace = ""
		end
		table.insert(cells, workspace)

		local cwd_uri = pane:get_current_working_dir()
		if cwd_uri then
			local cwd = ""
			local hostname = ""
			if type(cwd_uri) == "userdata" then
				-- Running on a newer version of wezterm and we have
				-- a URL object here, making this simple!
				cwd = cwd_uri.file_path
				hostname = cwd_uri.host or wezterm.hostname()
			else
				cwd_uri = cwd_uri:sub(8)
				local slash = cwd_uri:find("/")
				if slash then
					hostname = cwd_uri:sub(1, slash - 1)
					-- Remove the domain name portion of the hostname
					local dot = hostname:find("[.]")
					if dot then
						hostname = hostname:sub(1, dot - 1)
					end
					-- and extract the cwd from the uri
					cwd = cwd_uri:sub(slash)
					-- table.insert(cells, cwd)
					if hostname == "" then
						table.insert(cells, "")
					elseif string.find(hostname, "arch") then
						table.insert(cells, "")
					else
						table.insert(cells, "")
					end
				end
			end
		end
		local current_time = tonumber(wezterm.strftime("%H"))
	-- stylua: ignore
	local time = {
		[00] = "",
		[01] = "",
		[02] = "",
		[03] = "",
		[04] = "",
		[05] = "",
		[06] = "",
		[07] = "",
		[08] = "",
		[09] = "",
		[10] = "󰗲",
		[11] = "",
		[12] = "",
		[13] = "",
		[14] = "",
		[15] = "",
		[16] = "",
		[17] = "",
		[18] = "",
		[19] = "󰗲",
		[20] = "",
		[21] = "",
		[22] = "",
		[23] = "",
	}
		local date = wezterm.strftime("%H:%M:%S %a %b %d ")
		local date_time = time[current_time] .. " " .. date
		table.insert(cells, date_time)
		-- local SEPERATOR = " █"
		local SEPERATOR = "  "
		local pallete = {
			"#f7768e",
			"#9ece6a",
			"#7dcfff",
			"#bb9af7",
			"#e0af68",
			"#7aa2f7",
		}
		local cols = pane:get_dimensions().cols
		local padding = wezterm.pad_right("", (cols / 2) - string.len(date_time) - 2)
		local elements = {}
		local num_cells = 0

		-- Translate into elements
		local function push(text, is_last)
			local cell_no = num_cells + 1
			if is_last then
				-- table.insert(elements, text_fg)
				table.insert(elements, { Text = padding })
			end
			table.insert(elements, { Foreground = { Color = pallete[cell_no] } })
			table.insert(elements, { Background = { Color = terminal.colors.transparent } })
			table.insert(elements, { Text = "" .. text .. "" })
			if not is_last then
				table.insert(elements, { Foreground = { Color = terminal.colors.transparent } })
				table.insert(elements, { Background = { Color = terminal.colors.transparent } })
				table.insert(elements, { Text = SEPERATOR })
			end
			num_cells = num_cells + 1
		end

		while #cells > 0 do
			local cell = table.remove(cells, 1)
			push(cell, #cells == 0)
		end
		window:set_right_status(wezterm.format(elements))
	end)
end
return M
