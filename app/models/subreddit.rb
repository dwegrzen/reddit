class Subreddit < ActiveRecord::Base

  has_many :links

  validates :name, presence: true, uniqueness: true, exclusion: { in: %w(users subreddits links downvote upvote goto login logout),
    message: "%{value} is reserved." }

  def to_param
    name
  end


end
