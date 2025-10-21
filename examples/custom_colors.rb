require 'curses_menu'
require 'yaml'

# This is the simplest way to define a large color map
config = %w[examples/custom_colors.yml custom_colors.yml].find { |n| File.exist?(n) }
yaml_colors = YAML.load_file config
# Convert any constant names to the constant's value
# The constants are strings when loading a yaml file
yaml_colors.each_key do |name|
  fg, bg = *yaml_colors[name]
  yaml_colors[name][0] = Object.const_get(fg) if fg.is_a?(String) && Object.const_get(fg)
  yaml_colors[name][1] = Object.const_get(bg) if bg.is_a?(String) && Object.const_get(bg)
end

CursesMenu.install_curses_menu_colors(yaml_colors)

custom_color = {
  COLORS_TOPLEVEL: [Curses::COLOR_BLACK, Curses::COLOR_GREEN]
}

CursesMenu.install_curses_menu_colors custom_color

CursesMenu.new 'Top menu' do |menu|
  menu.item 'Enter menu 1' do
    CursesMenu.new 'Sub-menu 1' do |sub_menu|
      sub_menu.item 'We are in sub-menu 1'
      sub_menu.item CursesMenu::CursesRow.new(
        {
          first_cell: {
            text: 'This uses the UNDERLINED COLORS_MENU_ONE color',
            justify: :left,
            color_pair: CursesMenu::COLORS_MENU_ONE,
            text_attr: Curses::A_UNDERLINE
          }
        }
      )
      sub_menu.item('Back') { :menu_exit }
    end
  end
  menu.item 'Enter menu 2' do
    CursesMenu.new 'Sub-menu 2' do |sub_menu|
      sub_menu.item 'We are in sub-menu 2'
      sub_menu.item CursesMenu::CursesRow.new(
        {
          first_cell: {
            text: 'This uses the UNDERLINED COLORS_MENU_TWO color',
            justify: :left,
            color_pair: CursesMenu::COLORS_MENU_TWO,
            text_attr: Curses::A_UNDERLINE
          }
        }
      )
      sub_menu.item CursesMenu::CursesRow.new(
        {
          first_cell: {
            text: 'This uses the DIM UNDERLINED COLORS_MENU_TWO color',
            justify: :left,
            color_pair: CursesMenu::COLORS_MENU_TWO,
            text_attr: Curses::A_DIM | Curses::A_UNDERLINE
          }
        }
      )
      sub_menu.item('Back') { :menu_exit }
    end
  end
  menu.item CursesMenu::CursesRow.new(
    {
      first_cell: {
        text: 'This uses the COLORS_TOPLEVEL color',
        justify: :left,
        color_pair: CursesMenu::COLORS_TOPLEVEL,
        text_attr: Curses::A_BOLD
      }
    }
  )
  menu.item 'Quit' do
    puts 'Quitting...'
    :menu_exit
  end
end
