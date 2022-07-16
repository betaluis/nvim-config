local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install and Manage your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim", commit = "e4c2afb37d31e99b399425e102c58b091fbc16be" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", commit = "986ad71ae930c7d96e812734540511b4ca838aa2" }) -- Useful lua functions used ny lots of plugins
	use({ "windwp/nvim-autopairs", commit = "972a7977e759733dd6721af7bcda7a67e40c010e" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim", commit = "7c49fb2ac01a9f03410100c8e78f647bbea857e8" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })
	use({ "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" })
	use({ "kyazdani42/nvim-tree.lua", commit = "0f96e32326a842798b6b8e638a91464521e4ef71" })
	use({ "akinsho/bufferline.nvim", commit = "d7b775a35be9c80ed591d3335b35ec84e5c5d81e" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "588cf4185bf38875604d5c82efb34dd0ad2eed1f" })
	use({ "akinsho/toggleterm.nvim", commit = "8e6f938ed8eec7f988dc07aec2af148ad57c6d95" })
	use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
	use({ "lewis6991/impatient.nvim", commit = "2aa872de40dbbebe8e2d3a0b8c5651b81fe8b235" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" })
	use({ "goolord/alpha-nvim", commit = "417e756951cb0395f080f2c0eda84c8aadcbb80e" })
	use({ "famiu/bufdelete.nvim", commit = "46255e4a76c4fb450a94885527f5e58a7d96983c" })

  -- Smoot Scrolling
	use({ "karb94/neoscroll.nvim", commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
	use({ "lunarvim/darkplus.nvim", commit = "" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "9897465a7663997b7b42372164ffc3635321a2fe" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "981baf9525257ac3269e1b6701e376d6fbff6921" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "7d78278c2a935b8cd1b6b43065223e14490f3133" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "0e516c9d9892d6bf268492136971d315dd704d16" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "5011b8dd41700d7391a813e973d660a82f4630cf" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer", commit = "d6d564b21167161d85f41c2033ccc19a97b39a39" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "c9348b47918bee72b541580adf31e963c9028f82" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "b79cd6c88b3d96b0f49cb7d240807cd59b610cd8" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "d4eadbcaf1bb6251b37c697ff2c80929a6b2963b",
		run = ":TSUpdate",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "ffd06e36f6067935d8cb9793905dd2e84e291310" })

	-- DAP
	use({ "mfussenegger/nvim-dap", commit = "b9328b0cbd4dcbab29b1ce68f7103fe86a7703e1" })
	use({ "rcarriga/nvim-dap-ui", commit = "b0bc932ce6ca57bdec5536d773ab643e5b2f57ad" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
