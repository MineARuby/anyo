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
  end
end
