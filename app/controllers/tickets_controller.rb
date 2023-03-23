# frozen_string_literal: true

# This controller is user for handling Tickets
class TicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @user_tickets = @user.tickets
    @assigned_tickets = @user.assigned_tickets.where("aasm_state = 'inprogress' or aasm_state = 'closed'")
    @new_request_tickets = @user.assigned_tickets.where("aasm_state = 'opened' or aasm_state = 'reopened'")

    # @assigned_tickets = Ticket.where("assigned_to_id = ? and (aasm_state = 'inprogress' or aasm_state = 'closed')", @user.id)
    # @new_request_tickets = Ticket.where("assigned_to_id = ? and (aasm_state = 'opened' or aasm_state = 'reopened')", @user.id)
    # @tickets = Ticket.where("user_id = ? OR assigned_to= ? ",  @user.id,  @user.id)
  end

  def show
    @user = current_user
    # @ticket = @user.tickets.find_by_id(params[:id])
    @ticket = Ticket.find_by_id(params[:id])
  end

  def new
    @user = current_user
    @ticket = @user.tickets.new
  end

  def create
    @user = current_user
    @ticket = @user.tickets.new(ticket_params)

    if @ticket.save
      
      TicketGenerationMailer.ticket_generation(@ticket.assigned_to, current_user).deliver
      redirect_to tickets_path
    else
        # render :new
      redirect_to new_ticket_path
    end
  end

  def edit
    @ticket = Ticket.find_by_id(params[:id])
  end

  def update
    @ticket = Ticket.find_by_id(params[:id])
    
    if @ticket.update(ticket_params)
      @ticket.upgrade!
      redirect_to @ticket
    else
      render :edit
    end
  end

  def destroy
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.destroy
    redirect_to tickets_path
  end

  def fetch
    department_selected_option = params[:department_selected_option]
    options = User.where(department_id: department_selected_option)
    render json: options.to_json(only: [:id, :name])
  end

  # aasm event calling methods
  def accepted
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.accepted!
    redirect_to @ticket
  end

  def rejected
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.rejected!
    redirect_to @ticket
  end

  # change are required
  def after_due_date
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.accepted!
    redirect_to @ticket
  end

  def satisfied
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.satisfied!
    redirect_to @ticket
  end

  # def upgrade
  #   @ticket = Ticket.find_by_id(params[:id])

  #   @ticket.upgrade!
  # end

  def close
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.close!
    redirect_to @ticket
  end

  private

  def ticket_params
    params.require(:ticket).permit(:subject, :description, :due_date, :priority, :department_id, :assigned_to_id, :user_id)
  end
end
