class Link < ActiveRecord::Base

  belongs_to  :user
  belongs_to  :subreddit
  has_many :votes
  has_many :comments

  before_validation :http_check, on: :create
  validates :subreddit, presence: true
  validates :user, presence: true
  validates :title, presence: true
  validates :hyperlink, presence: true, :url => true

  def http_check
    unless self.hyperlink.start_with?('http://','https://')
      self.hyperlink = "http://"+self.hyperlink
    end
  end

end
