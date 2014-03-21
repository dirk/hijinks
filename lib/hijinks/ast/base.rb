module Hijinks::AST
  def self.from_twostroke(statements)
    statements.map {|s| Base.from_twostroke s }
  end
  
  class Base
    def self.from_twostroke s
      case s
      when Twostroke::AST::Variable
        Hijinks::AST::Variable.new(s.name)
      when Twostroke::AST::Assignment
        Hijinks::AST::Assignment.from_twostroke s
      when Twostroke::AST::Call
        Hijinks::AST::Call.from_twostroke s
      when Twostroke::AST::True
        Hijinks::AST::Bool.new(true)
      when Twostroke::AST::String
        Hijinks::AST::String.new(s.string)
      when Twostroke::AST::MemberAccess
        Hijinks::AST::MemberAccess.from_twostroke s
      else
        raise NoMethodError, "Can't parse #{s.inspect}"
      end
    end
    
  end
end
