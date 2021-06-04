class Api::V1::MvtimesController < Api::V1::BaseController
  def index
    @start_time = Time.now.to_f
    @file_name = "tmp/b" + SecureRandom.hex(10) + ".txt"
    File.open(@file_name, "w") do |fl|
      fl.write("")
    end
    f = File.open(@file_name)
    # puts "output after theoretical emptying"
    # puts f.read
    api_err = ApiErrorHandling.new
    @mvtime = api_err.check_integer(params[:mvtime], "mvtime", 1, 8000)
    @param_moves = params[:moves]
    @moves = api_err.check_moves(params[:moves], "moves")
    if !@mvtime[:error].nil?
      render json: { error: @mvtime[:error] }, status: 400
    elsif !@moves[:error].nil?
      render json: { error: @moves[:error] }, status: 400
    else
      deal_with_script
    end
  end

  private

  def deal_with_script
    pid = fork { exec("bin/mvtime_script.exp #{@mvtime[:value]} '" + @moves[:value].to_s  + "' > #{@file_name}") }
    Process.waitpid(pid, 0)
    f = File.open(@file_name)
    # puts "displaying output ?"
    content = f.read
    ct_array = content.split("EVALPART")
    variation_ct = ct_array[1].split(" pv ")[1].split(" bmc ")[0].split(" ").join(",")
    cpscore_ct = ct_array[1].split("score cp ")[1].split(" nodes ")[0].to_i
    cpscore = (@param_moves.split(",").length % 2).zero? ? cpscore_ct : -cpscore_ct
    # puts content
    @end_time = Time.now.to_f
    # puts "benchmark : #{@end_time - @start_time}"
    bmark = @end_time - @start_time
    render json: { pv: variation_ct, cp_score: cpscore, benchmark: bmark }, status: 200
  end
end
