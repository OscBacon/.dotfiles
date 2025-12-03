-- Basic settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.wo.wrap = false
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.showmode = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
-- vim.opt.swapfile = false
-- vim.opt.list = true
vim.opt.laststatus = 3
vim.opt.pumheight = 10
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- Allow more memory to draw syntax in longer files
vim.opt.maxmempattern = 50000

-- Basic mappings
-- vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
-- vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
-- vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
-- vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-S>", ":%s/")
vim.keymap.set("n", "sp", ":sp<CR>")
vim.keymap.set("n", "tj", ":tabprev<CR>")
vim.keymap.set("n", "tk", ":tabnext<CR>")
vim.keymap.set("n", "tn", ":tabnew<CR>")
vim.keymap.set("n", "to", ":tabo<CR>")
vim.keymap.set("n", "vs", ":vs<CR>")
vim.keymap.set("n", "<leader>j", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>k", ":cprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>O", ":only<CR>", { silent = true })

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field vim.uv.fs_stat does exist
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
	{
		"bkad/CamelCaseMotion",
		lazy = false,
		init = function()
			vim.g.camelcasemotion_key = ","
		end,
	},
	-- Multi cursors
	"mg979/vim-visual-multi",
	-- Automatic indentation
	"tpope/vim-sleuth",
	-- GitHub
	"tpope/vim-fugitive",
	{ "tpope/vim-rhubarb", lazy = false },
	-- Outline
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
	-- Fancy search and replace
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			} },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- Statusline,
	{
		"nvim-lualine/lualine.nvim",
		-- opts = {
		-- 	theme = "onedark",
		-- },
		config = function()
			local lualine = require("lualine")
			lualine.setup({
				options = {
					theme = "onedark",
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_x = { "encoding", { "filetype", icons_enabled = false } },
				},
			})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Cleaner code actions
	{ "luckasRanarison/clear-action.nvim", opts = {} },

	-- File browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		keys = {
			{ "<leader>n", ":Neotree toggle<CR>", { silent = true } },
			{ "<leader>N", ":Neotree toggle reveal_file=%<CR>", { silent = true } },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},

	-- TODO comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Better navigation between Neovim and Kitty
	"knubie/vim-kitty-navigator",

	-- Better quickfix lists
	"kevinhwang91/nvim-bqf",

	-- Autoclose HTML-style tags
	"windwp/nvim-ts-autotag",

	"onsails/lspkind.nvim",
	-- Error translator
	"dmmulroy/ts-error-translator.nvim",

	-- Easy commenting in normal & visual mode
	{ "numToStr/Comment.nvim", lazy = false },
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },

	-- LSP
	{
		"neovim/nvim-lspconfig",
		-- config = function()
		-- 	local lspconfig = require("lspconfig")
		-- 	lspconfig.eslint.setup({
		-- 		settings = {
		-- 			useESLintClass = true,
		-- 			packageManager = "pnpm",
		-- 		},
		-- 		root_dir = require("lspconfig.util").find_git_ancestor,
		-- 	})
		-- end,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"yioneko/nvim-vtsls",
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
	},

	-- Fuzzy finders
	-- TODO: Fix these having issues. Good for line completion
	{ "junegunn/fzf", build = "./install --bin", dir = "~/.fzf", lazy = false },
	{ "junegunn/fzf.vim", lazy = false },
	-- {
	-- 	"ibhagwan/fzf-lua",
	-- 	-- optional for icon support
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		-- calling `setup` is optional for customization
	-- 		require("fzf-lua").setup({ "fzf-vim" })
	-- 	end,
	-- },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		opts = {
			pickers = {
				git_commits = { previewer = false, theme = "ivy" },
				grep_string = { previewer = false, theme = "ivy" },
				diagnostics = { previewer = false, theme = "ivy" },
				find_files = { previewer = false, theme = "ivy" },
				buffers = { previewer = false, theme = "ivy" },
				current_buffer_fuzzy_find = { theme = "ivy" },
				resume = { previewer = false, theme = "ivy" },
				live_grep = { theme = "ivy" },
			},
			defaults = {
				layout_config = {
					prompt_position = "bottom",
				},
			},
		},
		keys = {
			{ "<leader>z", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "File fuzzy find" },
			{ "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Show diagnostics" },
			{ "<leader>w", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
			{ "<leader>g", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>F", "<cmd>Telescope git_files<cr>", desc = "Find files" },
			-- { "<leader>c", "<cmd>Telescope resume<cr>", desc = "Resume search" },
			{ "<leader>r", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Better syntax highlighting & much more
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = "all",
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true, enable_close_on_slash = false },
			})
		end,
	},

	-- Colorscheme
	{
		"rebelot/kanagawa.nvim",
		--    "kvrohit/rasmus.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			-- vim.cmd([[colorscheme rasmus]])
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	-- Surround words with characters in normal mode
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},

	-- For formatting code
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				graphql = { "prettierd" },
				json = { "prettierd" },
				css = { "prettierd" },
				lua = { "stylua" },
			},
			format_on_save = {},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- Pair matching characters
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},

	-- Gitsigns
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
})

vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])

-- Open Telescope on start
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argv(0) == "" then
			require("telescope.builtin").find_files()
		end
	end,
})

-- Set up Comment.nvim
require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	toggler = {
		line = "<leader>c ",
		block = "<leader>cm",
	},
})

-- Set up Mason and install set up language servers
require("mason").setup()
-- require("mason-lspconfig").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "vtsls" },
})

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				disable = { "missing-fields" },
			},
		},
	},
})
require("lspconfig").eslint.setup({
	settings = {
		useESLintClass = true,
		packageManager = "pnpm",
		workingDirectory = {
			mode = "location",
		},
	},
	-- root_dir = require("lspconfig.util").find_git_ancestor,
	root_dir = require("lspconfig.util").find_node_modules_ancestor,
	root_pattern = "pnpm-workspace.yaml",
})

-- Global LSP mappings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[g", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "]g", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- More LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gs", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", {})
		vim.keymap.set("n", "<leader>s", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>qf", function()
			vim.lsp.buf.code_action({ apply = true, context = { only = { "quickfix" } } })
		end, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<F3>", vim.lsp.buf.format, opts)
		vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, opts)
	end,
})

-- Set up nvim-cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
local cmp = require("cmp")

-- TODO: find better way to fix this
---@diagnostic disable-next-line: missing-fields
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

vim.g.python3_host_prog = vim.fn.expand("~/Envs/dev/bin/python")

require("ts-error-translator").setup()

require("telescope").load_extension("fzf")

vim.keymap.set("i", "<c-x><c-k>", "<plug>(fzf-complete-word)")
vim.keymap.set("i", "<c-x><c-l>", "<plug>(fzf-complete-line)")
vim.keymap.set("i", "<c-x><c-p>", "<plug>(fzf-complete-path)")
vim.keymap.set("i", "<c-x><c-p>", "<plug>(fzf-complete-path)")
vim.keymap.set("n", "<leader>qa", require("vtsls").commands.fix_all)
