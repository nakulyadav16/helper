class HomeController < ApplicationController
  before_action :authenticate_user! , only: [ :show]

  def index
  end

end
