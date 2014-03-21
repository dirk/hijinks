module Hijinks::AST
  
  class Call < Base
    attr_accessor :callee, :arguments
    
    def self.from_twostroke a
      assg = new
      assg.twostroke = a
      return assg
    end
    def twostroke= ts
      @callee = Hijinks::AST::Base.from_twostroke ts.callee
      @arguments = ts.arguments
      self
    end
    def compile block, gen
      callee_reg = block.next_reg
      # Getting the calle
      @callee.compile_to(block, gen, callee_reg)
      # raise NotImplementedError, "call:\n\t#{inspect}"
    end
  end
end
