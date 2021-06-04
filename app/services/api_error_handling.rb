class ApiErrorHandling
  def initialize
  end

  def check_fen(param_to_check, name_of_arg)
    res = { error: nil, value: "" }
    all_pieces = ["R", "K", "Q", "B", "N", "P", "r", "k", "q", "b", "n", "p"]
    if param_to_check.nil?
      res[:error] = "SyntaxError, #{name_of_arg} parameter missing"
    else
      fen_elts = param_to_check.split(",")
      if fen_elts.length != 6
        res[:error] = "SyntaxError (Malformed FEN), FEN must have 6 elements, it only has #{fen_elts.length}, did you separate the elements with commas ?"
      else
        fen_pos = fen_elts[0]
        fen_pos_array = fen_pos.split("/")
        if fen_pos_array.length != 8
          res[:error] = "SyntaxError (Malformed FEN), in the FEN the position must describe 8 ranks, it only describes #{fen_pos_array.length} of them"
        else
          fen_pos_array.each_with_index do |rk, i|
            rank_length = 0
            rk.each_char do |c|
              if !all_pieces.include?(c)
                if c.ord < 49 || c.ord > 56
                  res[:error] = "SyntaxError (Malformed FEN), rank number #{i + 1} hold a character that is neither an integer between 1 and 8, nor describing a piece (R, K, Q, B, N, P, r, k, q, b, n, p)"
                  break
                else
                  rank_length += c.ord - 48
                end
              else
                rank_length += 1
              end
            end
            if rank_length != 8
              res[:error] = "SyntaxError (Malformed FEN), rank number #{i + 1} describes the content of #{rank_length} files, it should describe the content of 8"
              break
            end
          end
        end
        if res[:error].nil?
          fen_to_move = fen_elts[1]
          if !["w", "b"].include?(fen_to_move)
            res[:error] = "SyntaxError (Malformed FEN), its second element is #{fen_to_move}, it should be either b or w"
          end
        end
        if res[:error].nil?
          regex = /(K?Q?k?q?|\-)/
          fen_castling = fen_elts[2]
          if !fen_castling.match(regex)
            res[:error] = "SyntaxError (Malformed FEN), its third element should describe castling rights (or their absence), it does not"
          end
        end
        if res[:error].nil?
          fen_en_passant = fen_elts[3]
          if fen_en_passant != "-"
            if fen_en_passant.length != 2
              res[:error] = "SyntaxError (Malformed FEN), its fourth element should show, either the absence of the possibility of en passant capture, or a square on which en passant capture can take place ; a square is denoted by 2 characters, but you gave #{fen_en_passant.length}"
            else
              en_passant_file = fen_en_passant[0]
              en_passant_rank = fen_en_passant[1]
              en_passant_file_ord = en_passant_file.ord
              if en_passant_file_ord < 97 || en_passant_file_ord > 104
                res[:error] = "SyntaxError (Malformed FEN), if its fourth element is present, it must be a square where en passant capture is possible, but you gave a string that does not start with a letter denoting a file (a to h)"
              else
                if en_passant_rank != 3 && en_passant_rank != "6"
                  res[:error] = "SyntaxError (Malformed FEN), if its fourth element is present, it must be a square where en passant capture is possible, but you gave a square that is neither located on the third or the sixth rank, which are the only ranks where en passant capture can take place"
                end
              end
            end
          end
        end
        if res[:error].nil?
          fen_fifty_moves = fen_elts[4]
          if fen_fifty_moves != "0" && fen_fifty_moves.to_i.to_s != fen_fifty_moves
            res[:error] = "SyntaxError (Malformed FEN), its fifth element is the number of half-moves elapsed since the last capture or advance of a pawn, but you did not provide an integer"
          else
            if fen_fifty_moves.to_i.negative?
              res[:error] = "SyntaxError (Malformed FEN), its fifth element is the number of half-moves elapsed since the last capture or advance of a pawn, but you did not provide a POSITIVE integer"
            end
          end
        end
        if res[:error].nil?
          fen_move_no = fen_elts[5]
          if fen_move_no != "0" && fen_move_no.to_i.to_s != fen_move_no
            res[:error] = "SyntaxError (Malformed FEN), its last element is the number of half-moves elapsed since the beginning of the game, starting at 1, but you did not provide an integer"
          else
            if fen_move_no.to_i < 1
              res[:error] = "SyntaxError (Malformed FEN), its last element is the number of half-moves elapsed since the beginning of the game, starting at 1, but you did not provide an integer that is higher than 0"
            end
          end
        end
      end
    end
    res[:value] = fen_elts.join(" ") if res[:error].nil?
    res
  end

  def check_integer(param_to_check, name_of_arg, minimum, maximum)
    res = {}
    if param_to_check.nil?
      res[:error] = "SyntaxError, #{name_of_arg} parameter missing"
    elsif param_to_check.to_i.zero?
      res[:error] = "SyntaxError, #{name_of_arg} parameter should be an integer"
    elsif param_to_check.to_i < minimum
      res[:error] = "OutOfRangeError, #{name_of_arg} parameter should be higher than #{minimum - 1}"
    elsif param_to_check.to_i > maximum
      res[:error] = "OutOfRangeError, #{name_of_arg} parameter should be lower than #{maximum + 1}"
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
          res[:error] = "#{i + 1}th move (#{m}) does not hold 4 or 5 characters, and is therefore not in long algebraic notation"
          break
        else
          mo = m[0].ord
          if mo < 97 || mo > 104
            res[:error] = "#{i + 1}th move (#{m}) starts with a character that is not a character between a and h, and is therefore not in long algebraic notation"
            break
          else
            mo = m[1].ord
            if mo < 49 || mo > 56
              res[:error] = "#{i + 1}th move's (#{m}) second character is not an integer between 1 and 8, and is therefore not in long algebraic notation"
              break
            else
              mo = m[2].ord
              if mo < 97 || mo > 104
                res[:error] = "#{i + 1}th move's(#{m}) third character is not a character between a and h, and is therefore not in long algebraic notation"
                break
              else
                mo = m[3].ord
                if mo < 49 || mo > 56
                  res[:error] = "#{i + 1}th move's (#{m}) fourth character is not an integer between 1 and 8, and is therefore not in long algebraic notation"
                  break
                elsif m.length == 5 && !["q", "r", "n", "b"].include?(m[4])
                  res[:error] = "#{i + 1}th move's (#{m}) fifth character is not a letter denoting a piece to which a pawn can be promoted (q for queen, r for rook, b for bishop, n for knight),  and is therefore not in long algebraic notation"
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
