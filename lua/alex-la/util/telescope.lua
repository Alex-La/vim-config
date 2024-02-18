local Util = require("alex-la.util")

---@class util.telescope.opts
---@field cwd? string|boolean
---@field show_untracked? boolean
---@field scope? "builtin" | "extensions"

---@class util.telescope
---@overload fun(builtin:string, opts?:util.telescope.opts)
local M = setmetatable({}, {
    __call = function(m, ...)
       return m.telescope(...)
    end,
})

-- this will return a function that calls telescope.
-- cwd will default to util.get_root
---@param picker string
---@param opts? util.telescope.opts
function M.telescope(picker, opts)
    local params = { picker = picker, opts = opts }

    return function()
        picker = params.picker
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = Util.root(), scope = "builtin" }, opts or {}) --[[@as util.telescope.opts]]

        if opts.cwd and opts.cwd ~= vim.loop.cwd() then
            ---@diagnostic disable-next-line: inject-field
            opts.attach_mappings = function(_, map)
                map("i", "<a-c>", function()
                    local action_state = require("telescope.actions.state")
                    local line = action_state.get_current_line()

                    M.telescope(
                        params.picker,
                        vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
                    )()
                end)

                return true
            end
        end
        
        if opts.scope =="builtin" then
            require("telescope.builtin")[picker](opts)
        elseif opts.scope == 'extensions' then
            require("telescope").extensions[picker][picker](opts)
        end
    end
end

function M.config_dir()
  return Util.telescope("file_browser", { scope="extensions", cwd = vim.fn.stdpath("config") })
end

return M