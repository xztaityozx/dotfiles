-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/xztaityozx/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/xztaityozx/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/xztaityozx/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/xztaityozx/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/xztaityozx/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["iceberg.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/opt/iceberg.vim",
    url = "https://github.com/cocopon/iceberg.vim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/lexima.vim",
    url = "https://github.com/cohama/lexima.vim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\29\0\0\1\0\1\0\2'\0\0\0L\0\2\0\18%3p%% %3l/%3L∫\f\1\0\n\0L\0‘\0013\0\0\0005\1\2\0005\2\1\0=\2\3\0015\2\4\0=\2\5\0015\2\6\0=\2\a\0016\2\b\0'\4\t\0B\2\2\0029\2\n\0025\4\27\0005\5\f\0005\6\v\0=\6\r\0055\6\14\0=\6\15\0055\6\16\0=\6\17\0055\6\18\0=\6\19\0055\6\20\0005\a\21\0005\b\22\0=\b\23\a>\a\2\6=\6\24\0055\6\25\0>\0\2\6=\6\26\5=\5\28\0045\5\29\0004\6\0\0=\6\r\0054\6\0\0=\6\15\0054\6\3\0006\a\b\0'\t\30\0B\a\2\0029\a\31\a>\a\1\6=\6\17\0054\6\0\0=\6\24\0055\6 \0=\6\26\5=\5\30\0045\5E\0005\6-\0005\a$\0005\b\"\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t#\t=\t\a\b=\b%\a5\b&\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b)\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b+\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a#\0065\a0\0005\b.\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t/\t=\t\a\b=\b%\a5\b1\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b2\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b3\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a/\0065\a6\0005\b4\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t5\t=\t\a\b=\b%\a5\b7\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b8\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b9\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a5\0065\a<\0005\b:\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t;\t=\t\a\b=\b%\a5\b=\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b>\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b?\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a;\0065\aA\0005\b@\0009\t\5\0019\t!\t=\t\5\b=\b%\a5\bB\0009\t\5\0019\t!\t=\t\5\b=\b'\a5\bC\0009\t\5\0019\t(\t=\t\5\b=\b*\a=\aD\6=\6F\0055\6G\0=\6H\0055\6I\0=\6J\5=\5K\4B\2\2\1K\0\1\0\foptions\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\ntheme\1\0\0\finacive\1\0\1\abg\f#1e2132\1\0\1\abg\f#262a3f\1\0\0\1\0\1\abg\f#33374c\1\0\0\1\0\0\1\0\0\1\0\0\freplace\1\0\0\1\0\0\1\0\0\1\0\0\1\0\0\vvisual\1\0\0\1\0\0\1\0\0\1\0\0\1\0\0\vinsert\1\0\0\1\0\0\6z\1\0\0\6c\1\0\0\nwhite\6b\1\0\0\6a\1\0\0\vnormal\1\0\0\nblack\1\2\0\0\ttabs\20tabline_buffers\ftabline\1\0\0\rsections\1\0\0\14lualine_z\1\2\0\0\rlocation\14lualine_y\fsymbols\1\0\3\tunix\14Óúí Linux\bmac\14Óúë macOS\bdos\16Óúè Windows\1\2\0\0\15fileformat\1\2\0\0\rencoding\14lualine_x\1\2\0\0#require('lsp-status').status()\14lualine_c\1\3\0\0\rfiletype\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\nsetup\flualine\frequire\abg\1\0\3\6z\f#e9b189\6b\f#818596\6c\f#262a3f\afg\1\0\2\nwhite\f#8389a3\nblack\f#1e2132\14indicator\1\0\0\1\0\4\vvisual\f#6845ad\vinsert\f#3f83a6\freplace\f#cc3768\vnormal\f#c57339\0\0" },
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  nerdcommenter = {
    loaded = true,
    needs_bufread = false,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/opt/nerdcommenter",
    url = "https://github.com/scrooloose/nerdcommenter"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\np\0\1\3\1\3\0\17-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\tÄ-\1\0\0009\1\1\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\2\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\fconfirm\23get_selected_entry\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_prev_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisibleú\3\1\0\t\0\27\0.6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\n\0005\4\4\0003\5\3\0=\5\5\0043\5\6\0=\5\a\0043\5\b\0=\5\t\4=\4\v\0039\4\f\0009\4\r\0044\6\3\0005\a\14\0>\a\1\0064\a\3\0005\b\15\0>\b\1\a5\b\16\0>\b\2\aB\4\3\2=\4\r\3B\1\2\0016\1\0\0'\3\17\0B\1\2\0029\1\18\0016\3\19\0009\3\20\0039\3\21\0039\3\22\3B\3\1\0A\1\0\0026\2\0\0'\4\23\0B\2\2\0029\2\24\0029\2\2\0025\4\25\0=\1\26\4B\2\2\0012\0\0ÄK\0\1\0\17capabilities\1\0\0\ngopls\14lspconfig\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\fsources\vconfig\fmapping\1\0\0\n<TAB>\0\f<S-TAB>\0\t<CR>\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["tabline.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\1\nsetup\ftabline\frequire\0" },
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/tabline.nvim",
    url = "https://github.com/kdheepak/tabline.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-cursorword"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/vim-cursorword",
    url = "https://github.com/itchyny/vim-cursorword"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/opt/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-goimports"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/vim-goimports",
    url = "https://github.com/mattn/vim-goimports"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  winresizer = {
    loaded = true,
    needs_bufread = false,
    path = "/home/xztaityozx/.local/share/nvim/site/pack/packer/opt/winresizer",
    url = "https://github.com/simeji/winresizer"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: nerdcommenter
time([[Setup for nerdcommenter]], true)
try_loadstring("\27LJ\2\nú\1\0\0\6\0\t\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\4\0'\4\5\0005\5\b\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1\6v\1\0\1\fnoremap\1\30<Plug>NERDCommenterToggle\asc\6n\20nvim_set_keymap\bapi\bvim\0", "setup", "nerdcommenter")
time([[Setup for nerdcommenter]], false)
time([[packadd for nerdcommenter]], true)
vim.cmd [[packadd nerdcommenter]]
time([[packadd for nerdcommenter]], false)
-- Setup for: winresizer
time([[Setup for winresizer]], true)
try_loadstring("\27LJ\2\n∞\1\0\0\2\0\6\0\0176\0\0\0009\0\1\0)\1a\0=\1\2\0006\0\0\0009\0\1\0)\1w\0=\1\3\0006\0\0\0009\0\1\0)\1s\0=\1\4\0006\0\0\0009\0\1\0)\1d\0=\1\5\0K\0\1\0\29winresizer_keycode_right\28winresizer_keycode_down\26winresizer_keycode_up\28winresizer_keycode_left\6g\bvim\0", "setup", "winresizer")
time([[Setup for winresizer]], false)
time([[packadd for winresizer]], true)
vim.cmd [[packadd winresizer]]
time([[packadd for winresizer]], false)
-- Setup for: vim-easymotion
time([[Setup for vim-easymotion]], true)
try_loadstring("\27LJ\2\n¿\1\0\0\6\0\v\0\0216\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\t\0'\3\6\0'\4\a\0005\5\n\0B\0\5\1K\0\1\0\1\0\1\fnoremap\1\6x\1\0\1\fnoremap\1\26<Plug>(easymotion-sn)\as/\6n\20nvim_set_keymap\bapi\26EasyMotion_do_mapping\6g\bvim\0", "setup", "vim-easymotion")
time([[Setup for vim-easymotion]], false)
time([[packadd for vim-easymotion]], true)
vim.cmd [[packadd vim-easymotion]]
time([[packadd for vim-easymotion]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n\29\0\0\1\0\1\0\2'\0\0\0L\0\2\0\18%3p%% %3l/%3L∫\f\1\0\n\0L\0‘\0013\0\0\0005\1\2\0005\2\1\0=\2\3\0015\2\4\0=\2\5\0015\2\6\0=\2\a\0016\2\b\0'\4\t\0B\2\2\0029\2\n\0025\4\27\0005\5\f\0005\6\v\0=\6\r\0055\6\14\0=\6\15\0055\6\16\0=\6\17\0055\6\18\0=\6\19\0055\6\20\0005\a\21\0005\b\22\0=\b\23\a>\a\2\6=\6\24\0055\6\25\0>\0\2\6=\6\26\5=\5\28\0045\5\29\0004\6\0\0=\6\r\0054\6\0\0=\6\15\0054\6\3\0006\a\b\0'\t\30\0B\a\2\0029\a\31\a>\a\1\6=\6\17\0054\6\0\0=\6\24\0055\6 \0=\6\26\5=\5\30\0045\5E\0005\6-\0005\a$\0005\b\"\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t#\t=\t\a\b=\b%\a5\b&\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b)\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b+\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a#\0065\a0\0005\b.\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t/\t=\t\a\b=\b%\a5\b1\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b2\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b3\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a/\0065\a6\0005\b4\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t5\t=\t\a\b=\b%\a5\b7\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b8\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b9\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a5\0065\a<\0005\b:\0009\t\5\0019\t!\t=\t\5\b9\t\3\0019\t;\t=\t\a\b=\b%\a5\b=\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t'\t=\t\a\b=\b'\a5\b>\0009\t\5\0019\t(\t=\t\5\b9\t\a\0019\t*\t=\t\a\b=\b*\a5\b?\0009\t\5\0019\t!\t=\t\5\b9\t\a\0019\t,\t=\t\a\b=\b,\a=\a;\0065\aA\0005\b@\0009\t\5\0019\t!\t=\t\5\b=\b%\a5\bB\0009\t\5\0019\t!\t=\t\5\b=\b'\a5\bC\0009\t\5\0019\t(\t=\t\5\b=\b*\a=\aD\6=\6F\0055\6G\0=\6H\0055\6I\0=\6J\5=\5K\4B\2\2\1K\0\1\0\foptions\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\ntheme\1\0\0\finacive\1\0\1\abg\f#1e2132\1\0\1\abg\f#262a3f\1\0\0\1\0\1\abg\f#33374c\1\0\0\1\0\0\1\0\0\1\0\0\freplace\1\0\0\1\0\0\1\0\0\1\0\0\1\0\0\vvisual\1\0\0\1\0\0\1\0\0\1\0\0\1\0\0\vinsert\1\0\0\1\0\0\6z\1\0\0\6c\1\0\0\nwhite\6b\1\0\0\6a\1\0\0\vnormal\1\0\0\nblack\1\2\0\0\ttabs\20tabline_buffers\ftabline\1\0\0\rsections\1\0\0\14lualine_z\1\2\0\0\rlocation\14lualine_y\fsymbols\1\0\3\tunix\14Óúí Linux\bmac\14Óúë macOS\bdos\16Óúè Windows\1\2\0\0\15fileformat\1\2\0\0\rencoding\14lualine_x\1\2\0\0#require('lsp-status').status()\14lualine_c\1\3\0\0\rfiletype\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\nsetup\flualine\frequire\abg\1\0\3\6z\f#e9b189\6b\f#818596\6c\f#262a3f\afg\1\0\2\nwhite\f#8389a3\nblack\f#1e2132\14indicator\1\0\0\1\0\4\vvisual\f#6845ad\vinsert\f#3f83a6\freplace\f#cc3768\vnormal\f#c57339\0\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\np\0\1\3\1\3\0\17-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\tÄ-\1\0\0009\1\1\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\2\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\fconfirm\23get_selected_entry\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_prev_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\21select_next_item\fvisibleú\3\1\0\t\0\27\0.6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\n\0005\4\4\0003\5\3\0=\5\5\0043\5\6\0=\5\a\0043\5\b\0=\5\t\4=\4\v\0039\4\f\0009\4\r\0044\6\3\0005\a\14\0>\a\1\0064\a\3\0005\b\15\0>\b\1\a5\b\16\0>\b\2\aB\4\3\2=\4\r\3B\1\2\0016\1\0\0'\3\17\0B\1\2\0029\1\18\0016\3\19\0009\3\20\0039\3\21\0039\3\22\3B\3\1\0A\1\0\0026\2\0\0'\4\23\0B\2\2\0029\2\24\0029\2\2\0025\4\25\0=\1\26\4B\2\2\0012\0\0ÄK\0\1\0\17capabilities\1\0\0\ngopls\14lspconfig\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\fsources\vconfig\fmapping\1\0\0\n<TAB>\0\f<S-TAB>\0\t<CR>\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: tabline.nvim
time([[Config for tabline.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\1\nsetup\ftabline\frequire\0", "config", "tabline.nvim")
time([[Config for tabline.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
