local LazyUtil = require("lazy.core.util")


---@class util: LazyUtilCore
---@field root util.root
local M = {}

setmetatable(M, {
    __index = function (t, k)
        if LazyUtil[k] then
            return LazyUtil[k]
        end

        t[k] = require("alex-la.util." .. k)

        return t[k]
    end
})

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
    local Config = require("lazy.core.config")
    if Config.plugins[name] and Config.plugins[name]._.loaded then
        fn(name)
    else
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyLoad",
            callback = function (event)
                if event.data == name then
                    fn(name)
                    return true
                end
            end,
        })
    end
end

return M