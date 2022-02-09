{ config, pkgs, ... }:

{
  programs.neovim = {
    extraPackages = with pkgs; [
      sqlite
      universal-ctags
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = coq_nvim;
        type = "lua";
        config = ''
          vim.g.coq_settings = {
            xdg = true,
            auto_start = 'shut-up',
            ['match.fuzzy_cutoff'] = 0.9,
          }
        '';
      }
      coq_artifacts
      {
        plugin = coq_thirdparty;
        type = "lua";
        config = ''
          require('coq_3p') {
            {
              src = 'bc',
              short_name = 'BC',
              precision = 6,
            },
            {
              src = 'repl',
              sh = 'zsh',
              shell = {
                n = 'node',
                p = 'perl',
                r = 'ruby',
              },
              max_lines = 99,
              deadline = 500,
              unsafe = { 'rm', 'poweroff', 'mv', 'reboot' },
            },
            {
              src = 'nvimlua',
              short_name = 'nLUA',
              conf_only = true,
            },
            {
              src = 'vimtex',
              short_name = 'vTEX',
            },
          }
        '';
      }

      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          local npairs = require('nvim-autopairs')

          npairs.setup {
            enable_check_bracket_line = false,
            map_bs = false,
            map_cr = false,
            check_ts = true,
          }

          vim.g.coq_settings = { keymap = { recommended = false } }

          vim.keymap.set('i', '<Esc>', [[pumvisible() ? '<C-e><Esc>' : '<Esc>']], { expr = true, noremap = true, silent = true })
          vim.keymap.set('i', '<C-c>', [[pumvisible() ? '<C-e><C-c>' : '<C-c>']], { expr = true, noremap = true, silent = true })
          vim.keymap.set('i', '<Tab>', [[pumvisible() ? '<C-n>' : '<Tab>']], { expr = true, noremap = true, silent = true })
          vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? '<C-p>' : '<BS>']], { expr = true, noremap = true, silent = true })

          _G.MUtils = {}
          
          MUtils.CR = function()
            if vim.fn.pumvisible() ~= 0 then
              if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
                return npairs.esc('<C-y>')
              else
                return npairs.esc('<C-e>') .. npairs.autopairs_cr()
              end
            else
              return npairs.autopairs_cr()
            end
          end

          vim.keymap.set('i', '<CR>', 'v:lua.MUtils.CR()', { expr = true, noremap = true, silent = true })
          
          MUtils.BS = function()
            if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
              return npairs.esc('<c-e>') .. npairs.autopairs_bs()
            else
              return npairs.autopairs_bs()
            end
          end

          vim.keymap.set('i', '<BS>', 'v:lua.MUtils.BS()', { expr = true, noremap = true,silent = true })
        '';
      }
    ];
  };
}
