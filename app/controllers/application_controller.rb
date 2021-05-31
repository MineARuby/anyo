class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_language

  def set_language
    if session[:lg].nil? || session[:lg] == 'fr'
      I18n.locale = 'fr'
    else
      I18n.locale = 'en'
    end
  end
end
