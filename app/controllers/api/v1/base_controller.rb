class Api::V1::BaseController < ActionController::API
  skip_before_action :authenticate_user!, only: [ :check_moves, :check_integer ]

  def check_integer(param_to_check, name_of_arg)
    res = {}
    if param_to_check.nil?
      res[:error] = "SyntaxError, #{name_of_arg} parameter missing"
    elsif param_to_check.to_i.zero?
      res[:error] = "SyntaxError, #{name_of_arg} parameter should be an integer"
    else
      res[:error] = nil
      res[:value] = param_to_check.to_i
    end
    res
  end

  def check_moves(param_to_check, name_of_arg)
    res = { error: nil, value: "" }
    if param_to_check.nil?
      res[:error] = "SyntaxError, #{name_of_arg} parameter missing"
    else
      moves_array = param_to_check.split(",")
      moves_array.each_with_index do |m, i|
        if m.length != 4 && m.length != 5
          res[:error] = "#{i}th move (#{m}) does not hold 4 or 5 characters, and is therefore not in long algebraic notation"
          break
        else
          mo = m[0].ord
          if mo < 97 || mo > 104
            res[:error] = "#{i}th move (#{m}) starts with a character that is not a character between a and h, and is therefore not in long algebraic notation"
            break
          else
            mo = m[1].ord
            if mo < 49 || mo > 56
              res[:error] = "#{i}th move's (#{m}) second character is not an integer between 1 and 8, and is therefore not in long algebraic notation"
              break
            else
              mo = m[2].ord
              if mo < 97 || mo > 104
                res[:error] = "#{i}th move's(#{m}) third character is not a character between a and h, and is therefore not in long algebraic notation"
                break
              else
                mo = m[3].ord
                if mo < 49 || mo > 56
                  res[:error] = "#{i}th move's (#{m}) fourth character is not an integer between 1 and 8, and is therefore not in long algebraic notation"
                  break
                elsif m.length == 5 && !["q", "r", "n", "b"].include?(m[4])
                  res[:error] = "#{i}th move's (#{m}) fifth character is not a letter denoting a piece to which a pawn can be promoted (q for queen, r for rook, b for bishop, n for knight),  and is therefore not in long algebraic notation"
                end
              end
            end
          end
        end
      end
    end
    res[:value] = moves_array.join(" ") if res[:error].nil?
    res
  end
end
