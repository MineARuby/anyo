class LanguagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :update ]

  def update
    lg = params[:id]
    session[:lg] = lg
    redirect_to root_path
  end
end
