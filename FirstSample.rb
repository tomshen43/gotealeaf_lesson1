
#require "/usr/local/Cellar/ruby/2.1.5/lib/ruby/gems/2.1.0/gems/pry-0.10.1/lib/pry.rb"
require 'pry'

def say(msg)
  puts "---- #{msg} ----"
end

say "what's the first number?"
num1 = gets.chomp

say "what's the second number?"
num2 = gets.chomp

say "1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp.to_i

binding.pry
if operator == 1
  result =num1.to_f + num2.to_f
elsif operator ==2
  result =num1.to_f - num2.to_f
elsif operator == 3
  result =num1.to_f * num2.to_f
else operator == 4
  result =num1.to_f / num2.to_f
  
end

say "Result is #{result}"