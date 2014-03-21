module Hijinks::AST
  
  class String < Base
    attr_accessor :value
    
    def initialize v
      @value = v
    end
    def compile_to block, gen, reg
      gen.set_string(reg, @value)
    end
    
  end
end
