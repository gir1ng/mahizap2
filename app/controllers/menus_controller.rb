class MenusController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def new
  end
end
