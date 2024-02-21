local Util = require("alex-la.util")


---@class Config
local M = {}

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
    local function _load(mod)
        if require("lazy.core.cache").find(mod)[1] then
            Util.try(function ()
                require(mod)
            end, { msg = "Failed loading " .. mod })
        end
    end

    _load("alex-la.config." .. name)
end

M.did_init = false
function M.init()
    if M.did_init then return end
    M.did_init = true

    M.load("options")
    
    local lazy_autocmds = vim.fn.argc(-1) == 0
    if not lazy_autocmds then
        M.load("autocmds")
    end
      
    local group = vim.api.nvim_create_augroup("AlexLa", { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        callback = function ()
            if lazy_autocmds then
                M.load("autocmds")
            end
            
            M.load("keymaps")
        end,
    })
end

return M