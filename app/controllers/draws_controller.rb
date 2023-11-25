class DrawsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:raffle]

  def index
    @draws = Draw.where(event_id: params[:event_id])
    @users_draw = Draw.where.not(user_id: current_user.id, was_drawn: false)
    @user_draw = Draw.where(event_id: params[:event_id], user_id: current_user.id).first
    user_draw_id = Draw.where(event_id: params[:event_id], user_id: current_user.id).first&.drawn_user_id
    if user_draw_id
      @user_drawn = User.find(user_draw_id)
      @user_drawn_raffle = Draw.where(event_id: params[:event_id], user_id: @user_drawn.id).first
    end
  end

  def create
    @draw = Draw.create(user_id: current_user.id, event_id: params[:event_id])
    if @draw.save
      redirect_to event_draws_path(event_id: @draw.event_id)
    else
      flash[:error] = "Something went wrong. Please try again."
    end
  end

  # TODO: impedir que ao apagar o disabled do botão faça um novo sorteio
  def raffle
    @event = Event.find(params[:event_id])
    @user_draw = Draw.where.not("user_id = ? OR was_drawn = ?", 1, true).shuffle.first
    @draw = Draw.where(user_id: current_user.id, event_id: params[:event_id]).first
    @draw&.drawn_user_id = @user_draw.user.id
  
    if @draw&.save!
      render :index
    end
  end

  def drawn
    @user_draw = Draw.where(event_id: params[:event_id], user_id: current_user.id).first.drawn_user_id
  end
end
