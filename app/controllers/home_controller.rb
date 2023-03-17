class HomeController < ApplicationController
  before_action :authenticate_user! , only: [ :show]

  def index
  end

  def show 
    @user = current_user
    @tickets = @user.tickets
  end


  def fetch
    department_selected_option = params[:department_selected_option]

    # @assined_users = User.where(department_id: department_selected_option)
    options = User.where(department_id: department_selected_option)

    render json: options.to_json(only: [:id, :name])
  end
end
