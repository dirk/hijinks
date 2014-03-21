module Hijinks::AST
  class Variable < Base
    attr_accessor :name
    
    def initialize name
      @name = name
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
