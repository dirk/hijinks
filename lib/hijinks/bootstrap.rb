module Hijinks
  class Bootstrap
    class << self
      def bootstrap vm
        gen = Hivm::Generator.new vm
        self.console gen
        
        chunk = gen.to_chunk
        chunk.disassemble
        exit 0
        vm.load_chunk chunk
      end
      def console gen
        b = Hivm::Block.new gen
        b.goto_label "defs"

        # Log function
        b.sub "console.log"
        string_reg = Hivm.param_register(0)
        sym_reg    = Hivm.general_register(0)
        b.move Hivm.arg_register(0), string_reg
        b.set_symbol sym_reg, "print"
        b.callprimitive sym_reg, Hivm.null_register
        b.return Hivm.null_register

        # Building the console object
        b.label "defs"
        # Creating the function
        func = Hivm.general_register 0
        sym  = Hivm.general_register 1
        val  = Hivm.general_register 2
        b.set_symbol sym, "_symbol"
        b.set_symbol val, "console.log"
        b.structnew func
        b.structset func, sym, val
        # Adding the function to the console object
        console = Hivm.general_register 4
        b.set_symbol sym, "log"
        b.structnew console
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
