class Api::V1::DepthevalsController < Api::V1::BaseController
  def index
    @start_time = Time.now.to_f
    @file_name = "tmp/a" + SecureRandom.hex(10) + ".txt"
    File.open(@filename, "w") do |fl|
      fl.write("")
    end
    f = File.open(@filename)
    puts "output after theoretical emptying"
    puts f.read
    @depth = API::V1::BaseController::check_integer(params[:depth], "depth")
    @moves = API::V1::BaseController::check_moves(params[:moves], "moves")
    if !@depth[:error].nil?
      render json: { error: @depth[:error] }, status: 400
    elsif !@moves[:error].nil?
      render json: { error: @moves[:error] }, status: 400
    else
      deal_with_script
    end
  end

  private

  def deal_with_script
    pid = fork { exec("bin/noexpect_script.exp #{@depth[:value]} #{@moves[:value]} > #{@file_name}") }
    Process.waitpid(pid, 0)
    f = File.open(@file_name)
    puts "displaying output ?"
    puts f.read
    @end_time = Time.now.to_f
    puts "benchmark : #{@end_time - @start_time}"
    bmark = @end_time - @start_time
    render json: { content: f.read, benchmark: bmark }, status: 200
  end
end
