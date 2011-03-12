module Enumerable
  def take_until
    memo = []
    each do |x|
      memo << x
      break if yield x
    end
    memo
  end
end

module Impl
  VERSION = '1.1'

  def generate(ctags, dir)
    memo = []
    Dir.glob(dir + '/**/*.c') do |f|
      File.read(f).each_line do |line|
        if /^\s*rb_define_(singleton_)?(?:private_)?method\(rb_.(.*?),\s*"(.*?)",\s*(\w+),(?#\))/ =~ line
          is_singleton, klass, method, func = [!!$1, $2, $3, $4]
          fullmethod = [klass, is_singleton ? '.' : '#', method].join
          ctags.scan(/^#{func}\t(.*)/) do |x|
            memo << "#{fullmethod}\t#{x[0]}"
          end
        end
      end
    end
    memo
  end
  module_function :generate

  def help
    <<-EOH
    impl version #{VERSION}

    USAGE
      impl -h:
               shows this message
      impl {directory} {method name}
               shows the file name and line number where {method name} like
               'Strimg#sum' defined, assuming the Ruby source directory is
               {directory}.
      impl -d {directory} {method name}
      impl --description {directory} {method name}
               shows the description of {method name} like 'Strimg#sum'
               directly, assuming the Ruby source directory is {directory}.
      impl -c {directory}:
      impl --create {directory}:
               shows additional information, assuming you already have
               |tags| and Ruby codes in the current directory.
    EOH
  end
  module_function :help

  def direct(base, name)
    unless File.exists?(base + 'tags')
      Dir.chdir base do
        system 'ctags -R'
      end
    end
    if /^String#sum/ !~ File.read(base + 'tags')
      Dir.chdir base do
        system 'impl -c .', out: ['tags', 'a']
      end
    end

    x = File.read(base + 'tags').
      each_line.
      select {|l| /^#{name}\t/ =~ l }.
      map {|l| l.split("\t") }.
      first
    r = Regexp.new(x[2][1..-4].gsub(/[\(\*\)]/) {|x| '\\' << x })
    file = base + x[1]
    content = File.read(file)
    line, i = content.
      each_line.
      with_index.
      detect {|line, _| r =~ line }
    content.each_line.drop(i).take_until {|line| /^}/ =~ line }
  end
  module_function :direct
end
