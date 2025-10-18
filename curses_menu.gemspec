require "#{__dir__}/lib/curses_menu/version"

Gem::Specification.new do |spec|
  spec.name = 'curses_menu'
  spec.version = CursesMenu::VERSION
  spec.authors = ['Muriel Salvan']
  spec.email = ['muriel@x-aeon.com']
  spec.license = 'BSD-3-Clause'
  spec.required_ruby_version = '>= 2.6'

  spec.summary = 'Simple menu offering choices with navigation keys using curses'
  spec.homepage = 'https://github.com/Muriel-Salvan/curses_menu'

  spec.metadata['homepage_uri'] = spec.homepage

  spec.files = Dir['*.md'] + Dir['{bin,docs,examples,lib,spec,tools}/**/*']
  spec.executables = Dir['bin/**/*'].map { |exec_name| File.basename(exec_name) }
  spec.extra_rdoc_files = Dir['*.md'] + Dir['{docs,examples}/**/*']

  spec.add_dependency 'curses', '~> 1.4'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
