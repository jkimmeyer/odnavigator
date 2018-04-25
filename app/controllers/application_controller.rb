class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :enable_pry

  private

  # This before_action enables pry for the next request, if it was disabled by `disable-pry`
  # See https://github.com/pry/pry/wiki/FAQ#wiki-disable_pry
  def enable_pry
    return if Rails.env.production?

    ENV['DISABLE_PRY'] = nil
  end
end
