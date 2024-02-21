local function augroup(name)
  return vim.api.nvim_create_augroup("alexla_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup("enter"),
    callback = function()
        if vim.fn.empty(vim.fn.argv()) == 0 and vim.fn.isdirectory(vim.fn.argv()[1]) == 1 then
            vim.cmd("Telescope file_browser")
        end
    end,
})