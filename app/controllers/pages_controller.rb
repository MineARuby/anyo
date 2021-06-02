class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    session[:white_sensi] = 25
    session[:black_sensi] = 25
    session[:play_white] = 'yes'
    session[:play_black] = 'yes'
    session[:depth] = 1
    session[:accuracy] = 25
    session[:all_openings] = 'yes'
    session[:caro_kann] = 'yes'
    session[:kings_ind_att] = 'yes'
    session[:kings_ind_def] = 'yes'
    session[:queens_ind_def] = 'yes'
    session[:dutch] = 'yes'
    session[:french] = 'yes'
    session[:ruy_lopez] = 'yes'
    session[:sicilian] = 'yes'
    session[:russian] = 'yes'
    session[:pirc] = 'yes'
    session[:alekhine] = 'yes'
    session[:modern] = 'yes'
    session[:english] = 'yes'
    session[:queens_gamb_acc] = 'yes'
    session[:queens_gamb_decl] = 'yes'
    session[:slav] = 'yes'
    session[:kings_gamb] = 'yes'
    session[:vienna] = 'yes'
    session[:italian] = 'yes'
    session[:trompovsky] = 'yes'
    session[:london] = 'yes'
    session[:scotch] = 'yes'
    session[:nimzo] = 'yes'
    session[:philidor] = 'yes'
    session[:scandinavian] = 'yes'
    session[:h_openings] = {}
    start = Time.now.to_f
    # IO.copy_stream("basic_script.exp", "copied_script.exp")
    str = "set depth 17\n"
    str += 'set variation "e2e4 e7e6 g1f3 b8c6"' + "\n"
    # exec("pwd")

    # CURRENT HALF-FUNCTIONING ONLINE CODE

    # IO.pipe do |read_pipe, write_pipe|
    # File.open("myoutput.txt", "w")
    fork { exec("bin/noexpect_script.exp >> tmp/myoutput.txt") }
    sleep 5
    f = File.open("tmp/myoutput.txt")
    puts "displaying output ?"
    puts f.read
    #   write_pipe.close
    #   while line = read_pipe.gets
    #     puts line
    #   end
    # end

    # END

    # IO.pipe do |read_pipe, write_pipe|
    #   system("bash", "./bin/noexpect_script.exp", out: write_pipe)
    #   write_pipe.close
    #   while line = read_pipe.gets
    #     puts line
    #   end
    # end
    # fork { exec("bin/basic_script3.exp") }
    # puts "pwd"
    # system("pwd")
    # puts "ls -lah"
    # system("ls -lah")
    # file_data = File.open("bin/basic_script3.exp").read
    # str += file_data
    # puts "NEW STR"
    # puts str
    # puts "pwd"
    # system("pwd")
    # puts "ls"
    # system("ls")
    # File.open("bin/copied_script3.exp", "w") do |f|
    #   f.write(str)
    # end
    # puts "pwd"
    # system("pwd")
    # puts "ls"
    # system("ls")
    # fork { exec("bin/copied_script3.exp") }
    #   system("expect", "copied_script.exp", out: write_pipe) }
    #   write_pipe.close
    #   while line = read_pipe.gets
    #     puts line
    #   end
    # end
    end_time = Time.now.to_f
    puts "benchmark : #{end_time - start}"
  end
end
