class Link < ActiveRecord::Base

  belongs_to  :user
  belongs_to  :subreddit

  validates :subreddit, presence: true
  validates :user, presence: true
  validates :title, presence: true
  validates :hyperlink, presence: true

end
