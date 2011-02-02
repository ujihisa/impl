module Impl
  VERSION = '1.0'

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
      impl -h: shows this message
      impl:    shows additional information, assuming you already have |tags|
               and Ruby codes in the current directory.
      impl --suite {directory}:
               generates new |tags| file in {directory} using files in
               {directory}.
    EOH
  end
  module_function :help
end
