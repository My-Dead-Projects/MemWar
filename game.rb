require_relative 'constant'
require_relative 'core'
require_relative 'vm'

class Game
  
  attr_reader :core, :p1, :p2
  attr_writer :core
  
  def initialize
    @core = Core.new
    @p1 = [VM.new(@core, 0)]
    @p2 = [VM.new(@core, C::MEMSIZE/2)]
  end
  
  #def run
  #  turns = 0
  #  i = k = 0
  #  while true
  #    p1[i].exec
  #    if p1[i].kill?
  #      p1.delete_at(i)
  #      if p1.size == 0
  #        return :p2win
  #      end
  #    else
  #      i += (1 % p1.size)
  #    end
  #    p2[k].exec
  #    if p2[k].kill?
  #      p2.delete_at(k)
  #      if p2.size == 0
  #        return :p1win
  #      end
  #    else
  #      k += (1 % p2.size)
  #    end
  #    turns += 1
  #    if turns >= C::MEMSIZE**2
  #      return :tie
  #    end
  #  end
  #end
  
  # returns false if file does not exist
  def load_prog(path, offset)
    begin
      if File.exist? path
        File.open(path) do |f|
          f.each_line do |line|
            if line =~ /[a-zA-Z]{3}( +[0-9a-fA-F]{1,2}){0,2} *(;.*)*/
              opcode = :"#{line[0..2]}"
              line.gsub!(/[a-zA-Z]{3} +/, '')
              l = line[0..1].to_i(16)
              line.gsub!(/[0-9a-fA-F]{1,2} +/, '')
              r = line[0..1].to_i(16)
              
              @core.mem[offset % C::MEMSIZE] = Instr.new(opcode, l, r)
            else
              return false # not a valid instruction
            end
            offset += 1
          end
        end
      end
      return File.exist? path
    rescue
      # catch all exceptions and return false
      # to avoid crashing the C context
      return false
    end
  end
  
end

if $0 == "embed"
  
  
  
end
