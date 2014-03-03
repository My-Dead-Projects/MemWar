require_relative 'core'

class VM
  
  def initialize(core, offset)
    @core = core
    @offset = offset
    @instr = @core.mem[@offset]
    @kill = false
    @instruction_set = {
      nop: 0x00,
      jmp: 0x01,
      jnz: 0x02,
      mov: 0x03,
      kil: 0x10
    }
  end
  
  def valid_instr?(instr)
    
  end
  
  def kill?
    @kill
  end
  
  def exec
    send(@instr.opcode, @instr.lfield, @instr.rfield)
  end
  
  #0x00
  def nop(l, r)
    jmp 1, 0
  end
  
  #0x01
  def jmp(l, r)
    @offset = (@offset+l) % C::MEMSIZE
    @instr = @core.mem[@offset]
  end
  
  #0x02
  def jnz(l, r)
    if r > 0
      jmp l, 0
    end
  end
  
  #0x03
  def mov(l, r)
    @core.mem[(@offset+l) % C::MEMSIZE] = @core.mem[(@offset+r) % C::MEMSIZE]
  end
  
  #0x10
  def kill(l, r)
    @kill = true
  end
  
end
