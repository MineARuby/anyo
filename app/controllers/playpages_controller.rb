class PlaypagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :create ]

  def index
  end

  def create
  end
end
