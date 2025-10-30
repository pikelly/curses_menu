# rubocop:disable RSpec/InstanceVariable
describe CursesMenu do

  before(:all) do # rubocop:disable RSpec/BeforeAfterAll
    # It seems that you can only call Curses.init_screen once per process
    @root = CursesMenu.root_window # rubocop:disable RSpec/DescribedClass
    raise('Unable to find the stored root_window') if @root.nil?

    @left_window = described_class.get_window(@root.maxy, @root.maxx / 2, 0, 0)
    @right_window = described_class.get_window(@root.maxy, @root.maxx / 2, 0, @root.maxx / 2)
  end

  after(:all) do # rubocop:disable RSpec/BeforeAfterAll
    @right_window&.close
    @left_window&.close
    Curses.close_screen
    @root&.close
  end

  it 'actions the default selection when pressed enter with pane' do
    actioned = false
    test_menu(keys: [CursesMenu::KEY_ENTER], window: @left_window) do |menu|
      menu.item 'Menu item' do
        actioned = true
      end
    end
    expect(actioned).to be(true)
  end

  it 'shows a message in a pane' do
    actioned = false
    test_menu(keys: [CursesMenu::KEY_ENTER], window: @left_window) do |menu|
      menu.item('messages', window: @right_window, pane: true) do |message_menu|
        message_menu.item 'This is a message'
      end
      menu.item 'Menu item' do
        actioned = true
      end
    end
    expect(actioned).to be(true)
    assert_line 3, 'This is a message', in_pane: true
  end

end
# rubocop:enable RSpec/InstanceVariable
