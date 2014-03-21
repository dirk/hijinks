module Hijinks::AST
  
  class Call < Base
    attr_accessor :callee, :arguments
    
    def self.from_twostroke a
      assg = new
      assg.twostroke = a
      return assg
    end
    def twostroke= ts
      @callee = ts.callee
      @arguments = ts.arguments
      self
    end
    def compile block, gen
    end
  end
end
