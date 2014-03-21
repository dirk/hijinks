module Hijinks::AST
  
  class Assignment < Base
    attr_accessor :left, :right
    
    def self.from_twostroke a
      assg = new
      assg.twostroke = a
      return assg
    end
    def twostroke= ts
      @left = ts.left
      @right = Hijinks::AST::Base.from_twostroke(ts.right)
      # @twostroke = ts
      self
    end
    
    def compile block, gen
      raise "Cannot handle @left of type #{@left.class.to_s}" unless @left.is_a? Twostroke::AST::Declaration
      left_reg = block.next_reg
      right_reg = block.next_reg
      # Name of the local var
      gen.set_symbol left_reg, @left.name
      # Value of the right hand side
      @right.compile_to(block, gen, right_reg)
      # Then assign
      gen.setlocal left_reg, right_reg
      
      # puts g.inspect
      # puts self.inspect
    end
    
  end
end
