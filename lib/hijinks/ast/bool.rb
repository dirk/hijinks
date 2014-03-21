module Hijinks::AST
  
  class Bool < Base
    attr_accessor :value
    
    def initialize v
      @value = v
    end
    def compile_to(gen, reg)
      gen.set_integer(reg, 1)
    end
    
  end
end
