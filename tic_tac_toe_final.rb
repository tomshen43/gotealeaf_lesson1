require 'pry'
def init_board
  board={}
  (1..9).each {|position| board[position]=' '}
  board
end

def empty_positions(board)
  board.keys.select {|position| board[position]==' '}
end

def player_move(board)
  begin
    puts "choose a position between 1 to 9"
    position = gets.chomp.to_i
  end until empty_positions(board).include?(position)
  board[position] = "X"
end

def board_filled?(board)
  empty_positions(board)==[]
end


def check_win(board,winning_set)
  winning_set.each do |line|
      return "Player" if board.values_at(*line).count("X")==3
      return "Computer" if board.values_at(*line).count("O")==3
  end
  nil
end

def computer_move(board,winning_set)
  temp=nil
  winning_set.each do |line|
    temp = check_two_in_the_row({line[0] =>board[line[0]], line[1] =>board[line[1]], line[2] =>board[line[2]]})
    if temp
      board[temp]="O"
      break
    end
  end
  board[empty_positions(board).sample] = "O" unless temp
end

def check_two_in_the_row(hsh)
    if hsh.values.count("X") == 2 and hsh.values.include?(" ")
      return hsh.select {|k,v| v==" "}.keys.first
    else 
      return false
    end
end

def announce_winner(winner)
  puts "#{winner} won the game"
end


def draw_board(board)
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


winning_set =[[1,2,3], [1,4,7],
              [1,5,9], [2,5,8],
              [3,5,7], [3,6,9],
              [4,5,6], [7,8,9]]


begin
  board = init_board
  draw_board(board)
    begin
      player_move(board)
      draw_board(board)
      computer_move(board,winning_set)
      draw_board(board)
      check_win(board,winning_set)
      winner = check_win(board,winning_set)
    end until winner || board_filled?(board)
    if winner
      announce_winner(winner)
    else
      puts "It is a tie!"
    end
    puts "New Game? (Y/N)"
    answer = gets.chomp
end until answer=="N"






