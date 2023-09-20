local file_type_yaml_ansible_augroup = vim.api.nvim_create_augroup("FileTypeYamlAnsible", {clear = true});
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
  pattern = {"ansible/*.yaml"},
  group = file_type_yaml_ansible_augroup,
  command = "setfiletype yaml.ansible"
});
