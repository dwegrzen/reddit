class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :set_score, only: [:index]


  # GET /links
  # GET /links.json
  def index
    if params[:search]
      @links = Link.where("title like ? or summary like ?", "%#{params[:search]}%", "%#{params[:search]}%").order(score: :desc).page(params[:page]).per(20)
      render :search
    else
      Link.all.each
      @links = Link.order(score: :desc).page(params[:page]).per(20)
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  def linkvote
    if current_user
      set_link
      @link.votes << Vote.new(value: 1, user: current_user)
      @link.update(score: @link.votes.sum(:value))
      redirect_to @link.hyperlink
    else
      set_link
      redirect_to @link.hyperlink
    end
  end

  def upvote
    if current_user
      set_link
      @link.votes << Vote.new(value: 1, user: current_user)
      @link.update(score: @link.votes.sum(:value))
      # redirect_to :back
    else
      respond_to do |format|
        format.html { redirect_to :login , notice: 'Please login to vote.' }
      end
    end
  end

  def downvote
    if current_user
      set_link
      @link.votes << Vote.new(value: -1, user: current_user)
      @link.update(score: @link.votes.sum(:value))
      # redirect_to :back
    else
      respond_to do |format|
        format.html { redirect_to :login , notice: 'Please login to vote.' }
      end
    end
  end


  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @match = Link.where("hyperlink = ?", params[:link][:hyperlink]).order(votes: :desc).first
    respond_to do |format|
      if @match
        @match.increment!("votes")
        format.html { redirect_to @match, notice: 'Link already exists, bringing to page.' }
      elsif @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    def set_score
      Link.all.map{|x| x.update(score: x.votes.sum(:value))}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :thumbnail, :user_id, :hyperlink, :summary, :votes, :subreddit_id)
    end
end
