HIVM_LIB = File.join(File.dirname(__FILE__), '..', '..', 'hivm', 'libhivm.so')

require 'rubygems'
# Development load-paths
$:.unshift File.join(File.dirname(__FILE__), "..", "..", "hivm-ruby", "lib")
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'hijinks'
require 'pp'

# vm = Hivm::VM.new
# gen = Hivm::Generator.new vm
# 
# gen.set_symbol Hivm.general_register(1), "_test"
# gen.callsymbolic Hivm.general_register(1), Hivm.general_register(2)
# gen.die
# 
# chunk = gen.to_chunk()
# chunk.disassemble

# source = "
# var a = \"test\n\";
# console.log(a);
# "
source = "
function a(b) {
  return c;
  return b;
}
console.log(a(\"test\\n\"));
"

lexer = Twostroke::Lexer.new(source)
parser = Twostroke::Parser.new lexer
parser.parse

# tree = parser.statements
# pp tree
block = Hijinks::AST::Block.new(parser.statements)
# pp block

vm  = Hivm::VM.new
gen = Hivm::Generator.new vm

vm.bootstrap_primitives
Hijinks::Bootstrap.bootstrap vm


#vm.run
#exit 0

# tree.map {|s| s.compile gen }
gen.set_file "(main)"
gen.debug_entry 1, "(main)"
block.compile gen

chunk = gen.to_chunk
# chunk.disassemble
# exit 0
vm.load_chunk chunk

# Hivm.hvm_print_data(vm[:program], vm[:program_size])

vm.run
