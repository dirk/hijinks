module Hijinks::AST
  class Variable < Base
    attr_accessor :name, :line
    
    def initialize name, line
      @name = name
      @line = line
    end
    def self.from_twostroke v
      return new(v.name, v.line)
    end
    def compile_to block, gen, reg
      gen.set_symbol reg, @name
      # In-place
      gen.getlocal reg, reg
    end
    def compile block, gen
      raise NotImplementedError, "variable:\n\t#{inspect}"
    end
  end
end
