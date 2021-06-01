require 'net/http'

class FindPuzzle
  def initialize(wsensi, bsensi, accuracy, depth, play_w, play_b, all_ops, ops_array)
    @wsensi = wsensi
    @bsensi = bsensi
    @accuracy = accuracy
    @depth = depth
    @play_w = play_w
    @play_b = play_b
    @all_ops = all_ops
    @ops_array = ops_array
  end

  def do_the_work
  end
end
