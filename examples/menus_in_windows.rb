require 'curses_menu'

root = CursesMenu.initialize_screen

left_window = CursesMenu.get_window(root.maxy, root.maxx / 2, 0, 0)
# right_window = screen.subwin(screen.maxy, screen.maxx / 2, 0, (screen.maxx / 2) - 1)

CursesMenu.new 'Top menu', window: left_window do |menu|
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
