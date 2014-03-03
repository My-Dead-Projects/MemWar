require_relative 'constant'

class Instr
  
  attr_reader :opcode, :l, :r
  attr_writer :opcode
  
  def initialize(opcode = :nop, l = 0, r = 0)
    @opcode = opcode
    @l = l
    @r = r
  end
  
  def l=(val)
    l = val % MEMSIZE
  end
  
  def r=(val)
    r = val % MEMSIZE
  end
  
end
