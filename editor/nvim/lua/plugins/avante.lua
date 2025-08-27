
return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  enabled = true,
  opts = {
    provider = "copilot",
    cursor_applying_prodiver = nil,
    behaviour = {
      enable_cursor_planning_mode = true
    },
    windows = {
      position = "right",
      width = 40，
      sidebar_header = {
        align = 'center',
        rounded = true,
      },
      input = {
        prefix = '>',
        height = 12,
      }
    },
    file_selector = {
      provider = 'telescope',
    }

  }
}
