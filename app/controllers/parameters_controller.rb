class ParametersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :create ]

  def index
  end

  def create
    puts pm_params
  end

  private

  def pm_params
    params.permit(:wsensi, :bsensi, :accuracy, :depth, :play_w, :play_b, :all_ops, opening_ids: [])
  end
end
