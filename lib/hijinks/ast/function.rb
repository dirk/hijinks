module Hijinks::AST
  class Function < Base
    class << self
      @@nonce = 0
      def next_nonce
        return (@@nonce += 1)
      end
    end
    
    attr_accessor :arguments, :statements, :name
    def self.from_twostroke s
      func = new
      func.name       = s.name
      func.arguments  = s.arguments
      func.statements = s.statements
      return func
    end
    def compile_to block, gen, reg
      if reg.nil?
        reg = block.next_reg
      end
      nonce = self.class.next_nonce
      label = "after_func_#{nonce.to_s}"
      sub   = "func_#{nonce.to_s}"
      gen.goto_label label

      # Encode the function body
      gen.sub sub
      sym = block.next_reg
      @arguments.each_with_index do |arg, i|
        gen.set_symbol sym, arg
        gen.setlocal sym, Hivm.param_register(i)
      end
      block = Hijinks::AST::Block.new(@statements)
      block.compile gen

      gen.label label
      # Create the function object
      sym = block.next_reg
      gen.set_symbol sym, "_js_new_function"
      gen.set_symbol Hivm.arg_register(0), sub
      gen.callsymbolic sym, reg

      gen.set_symbol sym, @name
      gen.setlocal sym, reg
    end
    def compile block, gen
      compile_to block, gen, nil
    end
  end
  
  class Return < Base
    attr_accessor :expression
    def initialize(ts)
      @expression = Hijinks::AST::Base.from_twostroke(ts.expression)
    end
    def compile block, gen
      return_reg = block.next_reg
      @expression.compile_to block, gen, return_reg
      gen.return return_reg
    end
  end
end
