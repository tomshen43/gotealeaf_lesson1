require 'pry'

cards = [2,3,4,5,6,7,8,9,10,'J','Q','K','A']
suits = ['Spade', 'Heart', 'Diamond', 'Club']
deck = cards.product(suits)
player_id=['Player','Computer']


def calc_sum(cards)
  sum=0
  arr=cards.map{|i| i[0]}
  arr.each do |v|
    if v == 'A'
      sum +=11
    elsif v.to_i == 0
      sum+=10
    elsif v == 'A'
      sum +=11
    else
      sum +=v.to_i
    end
  end
  arr.select{|a| a=='A'}.count.times do
    sum-=10 if sum > 21
  end
  sum
end

deck.shuffle!
player=Array.new
computer=Array.new
player<<deck.pop
computer<<deck.pop
player<<deck.pop
computer<<deck.pop
player_sum = calc_sum(player)
computer_sum = calc_sum(computer)
puts "
      You    have #{player[0]} and #{player[1]} with a total of #{player_sum}
      Dealer has a #{computer[0]} and #{computer[1]} with a total of #{computer_sum}"
if player_sum == 21
  puts "You has black jack, you lost!"
  exit
elsif computer_sum == 21
  puts "Dealer have black jack, you won!"
  exit
end
while player_sum <21
  puts "Do you want to hit or stay? (H/S)"
  hit_or_stay = gets.chomp
  if hit_or_stay == 'H'
    new_card=deck.pop
    puts "#{new_card} is dealt to the player"
    player<<new_card
    player_sum = calc_sum(player)
    puts "your total is #{player_sum} right now"
    if player_sum > 21
      puts " You have busted!"
      exit
    elsif player_sum ==21
      puts " You have 21, you won!"
      exit
    end
  elsif hit_or_stay=='S'
    puts "you chose to stay"
    break
  end
end
while computer_sum < 17
  dealer_card=deck.pop
  puts "#{dealer_card} is dealt to the computer"
  computer<<dealer_card
  computer_sum=calc_sum(computer)
  if computer_sum == 21
    puts "Dealer has 21, you lost!"
    exit
  elsif computer_sum >21
    puts "Dealer has busted"
    exit
  end
end
puts "You have"
player.each do |v|
  puts "=> #{v}"
end
puts "Computer has "
computer.each do |v|
  puts "=> #{v}"
end

if computer_sum < player_sum
  puts "You won! #{player_sum} beats #{computer_sum}"
elsif computer_sum > player_sum
  puts "You lost! #{computer_sum} beats #{player_sum}"
else
  puts "The game tied"
end



