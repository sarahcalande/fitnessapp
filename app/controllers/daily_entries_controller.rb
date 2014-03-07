class DailyEntriesController < ApplicationController
  def edit
    @entry = DailyEntry.find(params[:id])
  end

  def search
    @date = params[:entry][:date]
    @entry = current_user.daily_entries.includes(:meal_entries).where("entry_date = ?", params[:entry][:date]).first
    @user = current_user
    @diary = current_user.diaries.first
    if @entry
      @meal_entries = @entry.meal_entries
    end
    render :show
  end

  def complete
    if current_user.is_demo
      current_user.friends << User.first
      
      # TODO: automatically make the user friends with another existing user
      # TODO: automatically send messages when a user has new friend requests and/or new friends
      flash[:demo] = ["Wonderful! Your food journal for the day has been recorded."]
      flash[:demo] << "And look - we have a message. Let's <a href='#{messages_url}'>go to our inbox.</a>".html_safe
    end
    daily_entry = DailyEntry.find(params[:id])
    @feed_item = daily_entry.feed_items.new(user_id: current_user.id)
    @feed_item.body = "completed #{current_user.gender == "F" ? "her" : "his"} food diary for #{Date.today.strftime("%m-%d-%Y")}"

    if @feed_item.save
      flash[:notices] = ["Entry marked as complete!"]
      daily_entry.report_items.create(user_id: current_user.id)
    else
      flash[:errors] = @feed_item.errors.full_messages
    end

    redirect_to diary_user_url(current_user)
  end
end
