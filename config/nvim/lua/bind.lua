local api = vim.api
local map = api.nvim_set_keymap

-- sをトリガーに
map('n', 's', '<NOP>', { silent = true, noremap = true })
-- 現在バッファを右に開く
map('n', 'sv', '<CMD>vnew %<CR>', { noremap = true })

-- wasdでウィンドウ移動
map('n', 'sa', '<C-w>h', { noremap = true })
map('n', 'sw', '<C-w>k', { noremap = true })
map('n', 'ss', '<C-w>j', { noremap = true })
map('n', 'sd', '<C-w>l', { noremap = true })

-- インデント
map('n', 's=', 'gg=G', { noremap = true })
map('n', '>', '<S-v>>', { noremap = true })
map('n', '<', '<S-v><', { noremap = true })
map('v', '>', '>gv', { noremap = true })
map('v', '<', '<gv', { noremap = true })

-- 行を上下に動かす
map('n', '<C-Up>', '<CMD>move-1-{v:count1}<CR>', { noremap = true })
map('n', '<C-Down>', '<CMD>move+(v:count1)<CR>', { noremap = true })
map('x', '<C-Up>', ":move'<-2<CR>gv", { noremap = true, })
map('x', '<C-Down>', ":move'>+1<CR>gv", { noremap = true })

-- jjでESC
map('t', 'jj', '<C-\\><C-n>', { noremap = true })
map('i', 'jj', '<ESC>', { noremap = true })

-- Ctrl-dで:q
map('n', '<C-d>', "<CMD>q<CR>", { noremap = true })

-- Ctrl+sで保存
map('n', '<C-s>', '<CMD>:w<CR>', { noremap = true })
map('i', '<C-s>', '<ESC><CMD>:w<CR>', { noremap = true })

-- Yで選択部分をクリップボードへ
map('v', 'Y', '"+y', { noremap = true })
-- YYで現在行をクリップボードへ
map('n', 'YY', '"+yy', { noremap = true })
-- AYで全体をクリップボードへ
map('n', 'AY', 'gg<S-V>G"+yy', { noremap = true })


-- yuで行をヤンクしてから一行上にペースト
map('n', 'yu', 'yykp', { noremap = true })
-- ydで行をヤンクしてから一行下にペースト
map('n', 'yd', 'yyjp', { noremap = true })

-- terminalでESCを使う
map('t', '<ESC>', '<C-\\><C-n>', { noremap = true })

-- xを虚無へ捨てる
map('n', 'x', '"_x', { noremap = true })

-- U で Redo
map('n', 'U', '<C-r>', { noremap = true })

-- visual で yank した後にカーソル位置を戻す
map('x', 'y', 'mzy`z', { noremap = true })

-- <spase>でWord選択
map('n', '<space>', 'iW', { noremap = true })
map('x', '<space>', 'iW', { noremap = true })
