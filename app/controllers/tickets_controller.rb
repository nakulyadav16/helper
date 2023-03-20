class TicketsController < ApplicationController
    before_action :authenticate_user! 

    def index
      @user = current_user
      @user_tickets  = @user.tickets
      
      @assigned_tickets = Ticket.where("assigned_to = ?", @user.id)
      # @tickets = Ticket.where("user_id = ? OR assigned_to= ? ", @user.id , @user.id)
    end

    def new 
        @user = current_user
        @ticket = @user.tickets.new
    end

    def show
      @user = current_user
      @ticket = Ticket.find_by_id(params[:id])
    end

    def create 
        @user = current_user
        @ticket =@user.tickets.new(ticket_params)

        if @ticket.save
            redirect_to tickets_path
        else
            render :new
        end
    end


  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    redirect_to tickets_path
  end

  # def fetch
  #   department_selected_option = params[:department_selected_option]

  #   @assined_users = User.where(department_id: department_selected_option)

  #   # render json: options.to_json(only: [:id, :name])
  # end

  def fetch
    department_selected_option = params[:department_selected_option]

    # @assined_users = User.where(department_id: department_selected_option)
    options = User.where(department_id: department_selected_option)

    render json: options.to_json(only: [:id, :name])
  end





    private

    def ticket_params
        params.require(:ticket).permit(:subject,:description ,:due_date,:priority ,:department_id,:assigned_to ,:user_id)
    end
end
