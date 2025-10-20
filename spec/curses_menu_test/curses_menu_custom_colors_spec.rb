describe CursesMenu do

  it 'displays a custom color' do
    custom_color = {
      COLORS_TEST: [Curses::COLOR_BLACK, Curses::COLOR_MAGENTA]
    }
    described_class.install_curses_menu_colors(custom_color)

    test_menu do |menu|
      menu.item CursesMenu::CursesRow.new(
        {
          cell: {
            text: 'Colored string',
            color_pair: CursesMenu::COLORS_TEST
          }
        }
      )
    end
    assert_colored_line 3, 'Colored string', :COLORS_TEST
  end

end
