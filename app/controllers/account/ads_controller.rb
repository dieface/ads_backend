class Account::AdsController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @ads = current_user.ads
  end
end
