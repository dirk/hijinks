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
      @arguments = ts.arguments.map {|a| Hijinks::AST::Base.from_twostroke a }
      self
    end
    def compile_to block, gen, reg
      callee_reg = block.next_reg
      # Getting the calle
      @callee.compile_to(block, gen, callee_reg)
      arg_reg = block.next_reg
      @arguments.each_with_index do |arg, i|
        # puts i.to_s + ': ' + arg.inspect
        arg.compile_to(block, gen, arg_reg)
        gen.move Hivm.arg_register(i), arg_reg
      end
      sym = block.next_reg
      # Get the internal symbol of the callee
      gen.set_symbol sym, "_js_symbol"
      gen.structget sym, callee_reg, sym
      # Then call it
      gen.callsymbolic sym, reg
      
      # raise NotImplementedError, "call:\n\t#{inspect}"
    end
    def compile block, gen
      compile_to block, gen, Hivm.null_register
    end
  end
end
