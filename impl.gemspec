require File.expand_path('../lib/impl', __FILE__)
Gem::Specification.new do |s|
  s.name = %q{impl}
  s.version = Impl::VERSION.dup
  s.date = Time.now.strftime('%Y-%m-%d')

  s.summary = %q{What's the implementation of a Ruby method?}
  s.description = %q{generates additional information for Ruby C implementation's method definitions}

  s.author = 'ujihisa'
  s.email  = %q{ujihisa at gmail.com}

  s.files =
    Dir['lib/**/*'] +
    Dir['bin/**/*'] +
    Dir['spec/**/*'] +
    %w{ impl.gemspec Rakefile README.md }

  s.require_paths = ["lib"]
  s.executables = ['impl']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.homepage = %q{https://github.com/ujihisa/impl}

  s.extra_rdoc_files = %w< README.md >

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
end
