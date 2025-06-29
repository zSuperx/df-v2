local act = wezterm.action

config.leader = { key = "g", mods = "CTRL", timeout_milliseconds = 10000 }
config.keys = {
	{
		key = "g",
		mods = "LEADER|CTRL",
		action = act.ActivatePaneDirection("Next"),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "PaneMode",
			one_shot = false,
			prevent_fallback = true,
		}),
	},
	{
		key = "v",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	{
		key = "R",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			initial_value = "My Tab Name",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

local copy_mode = {}
local search_mode = {}
if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	local copy_mode_ext = {
		{
			key = "/",
			action = act.Multiple({
				act.CopyMode("ClearSelectionMode"),
				act.CopyMode("EditPattern"),
			}),
		},
		{
			key = "Escape",
			action = act.Multiple({
				act.CopyMode("ClearPattern"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "n",
			action = act.Multiple({
				act.CopyMode("NextMatch"),
				act.CopyMode("MoveToSelectionOtherEnd"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "N",
			action = act.Multiple({
				act.CopyMode("PriorMatch"),
				act.CopyMode("MoveToSelectionOtherEnd"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "y",
			action = act.Multiple({
				act.CopyTo("Clipboard"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "i",
			action = act.Multiple({
				act.CopyMode("MoveToScrollbackBottom"),
				act.CopyMode("Close"),
			}),
		},
		{
			key = "a",
			action = act.Multiple({
				act.CopyMode("MoveToScrollbackBottom"),
				act.CopyMode("Close"),
			}),
		},
	}

	search_mode = wezterm.gui.default_key_tables().copy_mode
	local search_mode_ext = {
		{
			key = "Enter",
			action = act.Multiple({
				act.CopyMode("AcceptPattern"),
				act.CopyMode("ClearSelectionMode"),
				act.CopyMode("NextMatch"),
			}),
		},
		{
			key = "Escape",
			action = act.Multiple({
				act.CopyMode("ClearSelectionMode"),
				act.CopyMode("ClearPattern"),
				act.CopyMode("AcceptPattern"),
			}),
		},
	}

	for _, item in ipairs(copy_mode_ext) do
		table.insert(copy_mode, item)
	end

	for _, item in ipairs(search_mode_ext) do
		table.insert(search_mode, item)
	end
end

config.key_tables = {
	copy_mode = copy_mode,
	search_mode = search_mode,
	ResizePane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		{ key = "Backspace", action = "PopKeyTable" },

		{ key = "Escape", action = "ClearKeyTableStack" },
		{ key = "Enter", action = "ClearKeyTableStack" },
		{ key = "i", action = "ClearKeyTableStack" },
	},

	PaneMode = {
		{
			key = "r",
			action = act.ActivateKeyTable({
				name = "ResizePane",
				one_shot = false,
				prevent_fallback = true,
			}),
		},
		{ key = "x", action = act.CloseCurrentPane({ confirm = true }) },

		{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "H", action = act.SplitPane({ direction = "Left" }) },

		{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },
		{ key = "L", action = act.SplitPane({ direction = "Right" }) },

		{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "K", action = act.SplitPane({ direction = "Up" }) },

		{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "J", action = act.SplitPane({ direction = "Down" }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "ClearKeyTableStack" },
		{ key = "Enter", action = "ClearKeyTableStack" },
		{ key = "i", action = "ClearKeyTableStack" },
	},
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.5,
}

config.window_frame = {
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 11,
}

wezterm.on("update-status", function(window, pane)
	local name = window:active_key_table()
	window:set_right_status(name or "InsertMode")
end)
