class HomeController < ApplicationController
  def index
  end

  def message
  	# @user = User.find(params[:id])
  	@users = User.all
  end  

  def lists
  end

  def money
  end
end

