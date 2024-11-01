-- ibl - indentation guides
-- :help ibl
local highlight = {
    "RosePineHighlightLow",
}

local hooks = require "ibl.hooks"
-- import colorscheme palette
local palette = require('rose-pine.palette')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RosePineHighlightLow", { fg = palette.highlight_low })
end)

require("ibl").setup { indent = { highlight = highlight } }

