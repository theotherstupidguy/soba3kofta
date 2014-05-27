#require "mushin"
=begin
%w(mushin).each do |library|
  begin
    require library
  rescue LoadError
    raise "== Soba3Kofta cannot run without #{library} installed"
  end
end
=end
require 'mushin'
require 'soba3kofta/base'
