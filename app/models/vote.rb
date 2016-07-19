class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  validates :link, presence: true
  validates :user, presence: true

end
