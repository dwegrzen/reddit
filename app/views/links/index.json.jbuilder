json.array!(@links) do |link|
  json.extract! link, :id, :title, :user_id, :hyperlink, :summary, :votes, :subreddit_id
  json.url link_url(link, format: :json)
end
