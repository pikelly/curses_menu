require 'curses_menu'

root = CursesMenu.initialize_screen

left_window = CursesMenu.get_window(root.maxy, root.maxx / 2, 0, 0)
right_window = CursesMenu.get_window(root.maxy, root.maxx / 2, 0, root.maxx / 2)

CursesMenu.new 'Top menu', window: left_window do |menu|
  # Pane menu items are always evaluated and at the same time as their header
  menu.item('messages', window: right_window, pane: true) do |message_menu|
    message_menu.item 'This is a message'
    message_menu.item CursesMenu::CursesRow.new(
      {
        first_cell: {
          text: 'and this message uses UNDERLINED COLORS_RED',
          justify: :left,
          color_pair: CursesMenu::COLORS_RED,
          text_attr: Curses::A_UNDERLINE
        }
      }
    )
  end
  menu.item 'Enter menu 1' do
    CursesMenu.new 'Sub-menu 1', window: left_window do |sub_menu|
      sub_menu.item 'We are in sub-menu 1'
      sub_menu.item('Back') { :menu_exit }
    end
  end
  menu.item 'Enter menu 2' do
    CursesMenu.new 'Sub-menu 2', window: left_window do |sub_menu|
      sub_menu.item 'We are in sub-menu 2'
      sub_menu.item('Back') { :menu_exit }
    end
  end
  menu.item 'Quit' do
    puts 'Quitting...'
    :menu_exit
  end
end
