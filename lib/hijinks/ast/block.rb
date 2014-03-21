module Hijinks::AST
  
  class Block < Base
    attr_accessor :statements, :regs
    
    def initialize stmts
      @statements = stmts
    end
    def compile g
      @regs = -1
      @statements.each do |s|
        s.compile self, g
      end
    end
    def next_reg
      @regs += 1
      return @regs
    end
  end
end
