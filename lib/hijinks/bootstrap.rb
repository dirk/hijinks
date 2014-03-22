module Hijinks
  class Bootstrap
    class << self
      def bootstrap vm
        gen = Hivm::Generator.new vm
        self.console gen
        
        chunk = gen.to_chunk
        #chunk.disassemble
        #exit 0
        vm.load_chunk chunk
      end
      def console gen
        b = Hivm::Block.new gen
        b.goto_label "defs"

        b.sub "_js_new_object"
        obj = Hivm.general_register 0
        b.structnew obj
        b.return obj

        b.sub "_js_new_function"
        func    = Hivm.general_register 0
        sym     = Hivm.general_register 1
        arg_sym = Hivm.general_register 2
        b.move arg_sym, Hivm.param_register(0)
        b.set_symbol sym, "_js_new_object"
        b.callsymbolic sym, func # Func will be object struct
        # Now set the internal symbol
        b.set_symbol sym, "_js_symbol"
        b.structset func, sym, arg_sym
        b.return func

        # Log function
        b.sub "console.log"
        string_reg = Hivm.param_register(0)
        sym_reg    = Hivm.general_register(0)
        # Copy string parameter into the argument
        b.move Hivm.arg_register(0), string_reg
        b.set_symbol sym_reg, "print"
        b.callprimitive sym_reg, Hivm.null_register
        b.return Hivm.null_register

        # Building the console object
        b.label "defs"
        # Creating the function
        func = Hivm.general_register 3
        sym  = Hivm.general_register 4
        b.set_symbol sym, "_js_new_function"
        b.set_symbol Hivm.arg_register(0), "console.log"
        b.callsymbolic sym, func
        # Adding the function to the console object
        console = Hivm.general_register 5
        b.set_symbol sym, "_js_new_object"
        b.callsymbolic sym, console # console now an object
        # Add function object in func to console
        b.set_symbol sym, "log"
        b.structset console, sym, func
        # Add console to the locals and globals
        b.set_symbol sym, "console"
        b.setlocal sym, console
        b.setglobal sym, console
        
        gen.push_block b
      end
    end#<<self
  end# Bootstrap
end# Hijinks
