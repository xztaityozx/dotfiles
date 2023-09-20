-- ansible/*.yamlなときは、filetypeをyaml.ansibleにする
-- ansibleのLSPを起動するために必要
local file_type_yaml_ansible_augroup = vim.api.nvim_create_augroup("FileTypeYamlAnsible", {clear = true});
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
  pattern = {"ansible/*.yaml"},
  group = file_type_yaml_ansible_augroup,
  command = "setfiletype yaml.ansible"
});

-- Perlのときはインデント幅を4にする
local file_type_perl_augroup = vim.api.nvim_create_augroup("FileTypePerl", {clear = true});
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
  pattern = {"*.pl", "*.pm", "t/*.t"},
  group = file_type_perl_augroup,
  callback = function ()
    vim.opt_local.shiftwidth = 4
  end
});

-- tfファイルのときはfiletypeをterraformにする
-- terraformのLSPを起動するために必要。tfって基本terraformだと思うけどなんで変わらんのだろ
local file_type_terraform_augroup = vim.api.nvim_create_augroup("FileTypeTerraform", {clear = true});
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
  pattern = {"tf"},
  group = file_type_terraform_augroup,
  callback = function ()
    vim.bo.filetype = "terraform"
  end
});
