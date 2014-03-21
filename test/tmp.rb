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

source = "
var a = \"test\";
console.log(a);
"

lexer = Twostroke::Lexer.new(source)
parser = Twostroke::Parser.new lexer
parser.parse

# tree = parser.statements
# pp tree
statements = Hijinks::AST.from_twostroke(parser.statements)
block = Hijinks::AST::Block.new(statements)

vm  = Hivm::VM.new
gen = Hivm::Generator.new vm

Hijinks::Bootstrap.bootstrap vm

# tree.map {|s| s.compile gen }
block.compile gen

chunk = gen.to_chunk
chunk.disassemble

#vm.load_chunk chunk
#vm.run
