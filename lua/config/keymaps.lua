vim.keymap.set("n", "<leader>z", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Wrap is now: " .. tostring(vim.wo.wrap))
end, { desc = "Toggle wrap" })
