class WeighIn < ActiveRecord::Base
  attr_accessible :user_id, :current_wt, :previous_wt

  belongs_to :user
  has_many :feed_items, as: :feed_update, dependent: :destroy
  has_many :report_items, as: :reportable, dependent: :destroy
end
