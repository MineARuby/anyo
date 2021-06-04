class Api::V1::FendepthevalsController < Api::V1::BaseController
  def index
    @start_time = Time.now.to_f
    @file_name = "tmp/c" + SecureRandom.hex(10) + ".txt"
    File.open(@file_name, "w") do |fl|
      fl.write("")
    end
    f = File.open(@file_name)
    # puts "output after theoretical emptying"
    # puts f.read
    api_err = ApiErrorHandling.new
    @depth = api_err.check_integer(params[:depth], "depth", 1, 20)
    @param_moves = params[:moves]
    @moves = api_err.check_moves(params[:moves], "moves")
    @param_fen = params[:fen]
    @fen = api_err.check_fen(@param_fen, "fen")
    if !@depth[:error].nil?
      render json: { error: @depth[:error] }, status: 400
    elsif !@moves[:error].nil?
      render json: { error: @moves[:error] }, status: 400
    elsif !@fen[:error].nil?
      render json: { error: @fen[:error] }, status: 400
    else
      deal_with_script
    end
  end

  private

  def deal_with_script
    pid = fork { exec("bin/feneval_script.exp #{@depth[:value]} #{@moves[:value]} #{@fen[:value]} > #{@file_name}") }
    Process.waitpid(pid, 0)
    f = File.open(@file_name)
    # puts "displaying output ?"
    content = f.read
    ct_array = content.split("INISHED")[1].split("EVALPART")
    bestmv_ct = ct_array[0].split("estmove ")[1].split("ponder ")
    bestmv = bestmv_ct[0]
    pondermv = bestmv_ct[1].strip
    variation_ct = ct_array[1].split(" pv ")[1].split(" bmc ")[0].split(" ").join(",")
    cpscore_ct = ct_array[1].split("score cp ")[1].split(" nodes ")[0].to_i
    cpscore = (@param_moves.split(",").length % 2).zero? ? cpscore_ct : -cpscore_ct
    # puts content
    @end_time = Time.now.to_f
    # puts "benchmark : #{@end_time - @start_time}"
    bmark = @end_time - @start_time
    render json: { fen: @param_fen, pv: variation_ct, depth: @depth[:value], moves: @param_moves, bestmove: bestmv, pondermove: pondermv, cp_score: cpscore, benchmark: bmark }, status: 200
  end
end
