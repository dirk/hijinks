module Hijinks::AST
  
  class Block < Base
    attr_accessor :statements, :regs
    
    def initialize stmts
      @statements = stmts.map {|s| Hijinks::AST::Base.from_twostroke s }
    end
    def compile g
      @regs = -1
      @statements.each do |s|
        s.compile self, g
      end
    end
    def next_reg
      if @regs == 127
        raise "Out of registers"
      end
      @regs += 1
      return Hivm.general_register(@regs)
    end
  end
end
