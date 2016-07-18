class Subreddit < ActiveRecord::Base

  has_many :links

  validates :name, presence: true, exclusion: { in: %w(users subreddits links downvote upvote goto),
    message: "%{value} is reserved." }

    def to_param
      name
    end



end
