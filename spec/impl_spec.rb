require_relative '../lib/impl'

describe Impl do
  describe '.generate' do
    context 'with a tag file and a repository dir' do
      it 'returns strings of additional information like Random#rand, ' +
        'assuming the ruby source code repo is in ~/git/ruby193' do
        dir = File.expand_path('~/git/ruby193')
        ctags = File.read(dir + '/tags')
        Impl.generate(ctags, dir).should be_include 'Random#rand	random.c	/^random_rand(int argc, VALUE *argv, VALUE obj)$/;"	f	file:'
      end
    end
  end

  describe '.help' do
    it 'returns help message' do
      Impl.help.should be_include 'USAGE'
    end
  end
end

#describe 'bin/impl' do
# rb_define_singleton_method(rb_vm_top_self(), "to_s", main_to_s, 0);
