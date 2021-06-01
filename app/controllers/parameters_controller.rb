class ParametersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :create ]

  def index
  end

  def create
    session[:white_sensi] = pm_params[:wsensi] if pm_params[:wsensi].class.name == 'Integer'
    session[:black_sensi] = pm_params[:bsensi] if pm_params[:bsensi].class.name == 'Integer'
    session[:accuracy] = pm_params[:accuracy] if pm_params[:accuracy].class.name == 'Integer'
    session[:depth] = pm_params[:depth] if pm_params[:depth].class.name == 'Integer'
    session[:play_white] = 'no' if pm_params[:play_w].nil?
    session[:play_black] = 'no' if pm_params[:play_b].nil?
    session[:all_openings] = 'no' if pm_params[:all_ops].nil?
    h_openings = pm_params[:opening_ids]
    session[:h_openings] = h_openings
    Opening.all.each do |op|
      session[op[:session_name].to_sym] = 'no' unless h_openings.keys.include?(op.to_s)
    end
    redirect_to playpages_path
  end

  private

  def pm_params
    params.permit(:wsensi, :bsensi, :accuracy, :depth, :play_w, :play_b, :all_ops, opening_ids: {})
  end
end
