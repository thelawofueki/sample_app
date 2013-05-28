class StaticPagesController < ApplicationController
  before_filter :signed_in_user, only: [:help]
  def home
  end

  def help
  end

  def about
  end

  def contacts
  end
private
  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end
end
