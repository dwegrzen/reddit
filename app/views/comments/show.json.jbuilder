json.extract! @comment, :body, :created_at
json.extract! @comment.user, :username
