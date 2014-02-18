class GoalsController < ApplicationController
  before_filter :require_logged_in

  def new
    @goal = current_user.build_goal
  end

  def create
    @goal = current_user.build_goal
    @goal.update_attributes(params[:goals])

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end
end

