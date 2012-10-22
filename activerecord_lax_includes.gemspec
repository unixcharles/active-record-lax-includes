Gem::Specification.new do |s|
  s.name        = 'activerecord_lax_includes'
  s.version     = '0.1.1'
  s.summary     = 'Hotfix nested eager loading for polymorphic and STI relation in ActiveRecord'
  s.author      = 'Charles Barbier'
  s.email       = 'unixcharles@gmail.com'
  s.homepage    = 'http://github.com/unixcharles/active-record-lax-includes'

  s.files        = Dir['README.md', 'LICENSE', 'lib/activerecord_lax_includes.rb']
  s.require_path = 'lib'
end
