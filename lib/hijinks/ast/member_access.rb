module Hijinks::AST
  class MemberAccess < Base
    attr_accessor :object, :member, :line, :name
    
    def self.from_twostroke a
      ma = new
      ma.twostroke = a
      return ma
    end
    def twostroke= ts
      @object = Hijinks::AST::Base.from_twostroke ts.object
      @member = ts.member
      @line = @object.line
      @name = @object.name+'.'+@member
      self
    end
    def compile_to block, gen, reg
      @object.compile_to block, gen, reg
      key_reg    = block.next_reg
      gen.set_symbol key_reg, @member
      # In-place
      struct_reg = reg
      dest_reg   = reg
      gen.structget dest_reg, struct_reg, key_reg
      
      # puts @object.inspect
      # puts @member.inspect
    end
    def compile block, gen
      raise NotImplementedError, "call:\n\t#{inspect}"
    end
  end
end
