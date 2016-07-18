class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    if params[:search]
      @searchparam = params[:search]
      @links = Link.where("title like ? or summary like ?", "%#{@searchparam}%", "%#{@searchparam}%").order(votes: :desc).page(params[:page]).per(20)
      render :search
    else
      @links = Link.order(votes: :desc).page(params[:page]).per(20)
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  def linkvote
    set_link
    @link.increment!("votes")
    redirect_to @link.hyperlink
  end

  def upvote
    set_link
    @link.increment!("votes")
    redirect_to :back
  end

  def downvote
    set_link
    @link.decrement!("votes")
    redirect_to :back
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

  def search(param)
    @searchparam = param
    @links = []
    @links += Link.where('title like ?', "%#{@searchparam}%")
    @links += Link.where('summary like ?', "%#{@searchparam}%")
    @links.uniq!
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :thumbnail, :user_id, :hyperlink, :summary, :votes, :subreddit_id)
    end
end
