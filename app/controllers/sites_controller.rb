class SitesController < ApplicationController

  def new
    @site = Site.new
  end

  def create
    begin
      @site = Site.create_site(current_user)
    rescue
      render :new, status: :unprocessable_entity
    end

    sleep 10.0
    @site.reload
    
    if @site.status == "deleted"
      render json: {status: "error", code: 500, message: "Unable to create site. Try again later."}
    else
      redirect_to @site
    end
  end

  def show
    @site = Site.find(params[:id])
  end
  
end
