return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },

        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,

                default_component_configs = {
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "",
                        default = "",
                    },
                },

                filesystem = {
                    components = {
                        icon = function(config, node, state)
                            local icon = config.default or ""

                            if node.type == "directory" then
                                icon = node:is_expanded() and "" or ""
                            else
                                local ok, devicons = pcall(require, "nvim-web-devicons")
                                if ok then
                                    icon = devicons.get_icon(node.name, nil, { default = true }) or icon
                                end
                            end

                            return {
                                text = icon .. " ",
                                highlight = config.highlight or "NeoTreeFileIcon",
                            }
                        end,
                    },

                    filtered_items = {
                        visible = false,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },

                window = {
                    width = 30,
                },
            })

            vim.keymap.set(
                "n",
                "<leader>e",
                ":Neotree toggle filesystem left<CR>",
                { desc = "Toggle Neo-tree" }
            )
        end,
    },
}
