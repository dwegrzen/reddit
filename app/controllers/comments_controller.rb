class CommentsController < ApplicationController
  before_action :require_user, only: [:create]



  def create
    @comment = current_user.comments.create!(
    link_id: params[:link_id],
    body: params[:comment][:body]
    )
    @link = Link.find(params[:link_id])
    # redirect_to @link
    respond_to do |format|
      format.json {render :show, status: :created, location: [@comment.link, @comment]}
      format.html {redirect_to @link}
      end
    end

  def show
    @comment = Comment.find(params[:id])
    @link = @comment.link

  end



end
