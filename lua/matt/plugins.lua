local fn = vim.fn

local installPath = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(installPath)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		installPath,
	}
	print "Installing packer, close and reopen Neovim"
	vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float {border = "rounded"}
		end,
	},
}

return packer.startup(function(use)
	-- packer
	use "wbthomason/packer.nvim"
	-- basic plugins
	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"

	-- colorscheme
	use "folke/tokyonight.nvim"

	-- cmp plugins
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "saadparwaiz1/cmp_luasnip"

	-- snippets
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	if PACKER_BOOSTRAP then
		require("packer").sync()
	end
end)
