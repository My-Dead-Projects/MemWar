require_relative 'constant'
require_relative 'instr'

class Core
  
  attr_accessor :mem
  
  def initialize
    @mem = Array.new(C::MEMSIZE, Instr.new)
  end
  
end
