require 'pry'

class Player
  attr_reader :name, :mark
  def initialize(n,m)
    @name = n
    @mark = m
  end
end

class Human<Player
  def move(empty,board)
    begin
      puts "choose a position between 1 to 9"
      temp = gets.chomp.to_i
    end until empty.include?(temp)
    board[temp] = 'X'
    empty.delete(temp)
  end
end

class Computer<Player
  def move(empty,board)
    temp=nil
    Game::WINNING_SET.each do |line|
      temp = check_two_in_the_row({line[0] =>board[line[0]], line[1] =>board[line[1]], line[2] =>board[line[2]]})
      if temp
        board[temp]="O"
        break
      end
    end
    unless temp
      temp = empty.sample
      board[temp] = "O"
      empty.delete(temp)
    end
    empty.delete(temp)
  end

  def check_two_in_the_row(hsh)
    if hsh.values.count("X") == 2 and hsh.values.include?(" ")
      return hsh.select {|k,v| v==" "}.keys.first
    else 
      return false
    end
  end
end

class Game
  WINNING_SET =[[1,2,3], [1,4,7],
                [1,5,9], [2,5,8],
                [3,5,7], [3,6,9],
                [4,5,6], [7,8,9]]
  attr_accessor :board, :empty
  def initialize
    @player = Human.new('TOM','X')
    @computer = Computer.new('R2D2','O')
    @board = {}
    (1..9).each {|position| board[position]=' '}
    @empty = @board.keys.select {|position| board[position]==' '}
    @current_player = @player
  end

  def draw
  system("clear")
  puts "
                  |      |            
              #{board[1]}   |   #{board[2]}  |   #{board[3]}     
          --------+------+------
              #{board[4]}   |   #{board[5]}  |   #{board[6]} 
          --------+------+-------
              #{board[7]}   |   #{board[8]}  |   #{board[9]}
                  |      |       "
  end

  def alternate_player
    if @current_player == @player
      @current_player = @computer
    else
      @current_player = @player
    end
  end

  def check_win
    WINNING_SET.each do |line|
    @winner = @current_player.name if board.values_at(*line).count(@current_player.mark)==3
    end
  end

  def play_again
    puts "Do you want to play again? (Y/N)"
    ans= gets.chomp
    if ans == 'Y'
      Game.new.play
    else
      exit
    end
  end

  def play
    draw
    loop do
      @current_player.move(empty,board)
      draw
      check_win
      if @winner
        puts "#{@winner} won the game"
        break
      elsif empty ==[]
        puts "The game is a tie"
        break
      end
      alternate_player
    end
    play_again
  end

end

Game.new.play

