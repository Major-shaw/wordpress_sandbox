class SitesController < ApplicationController

  def new
    @site = Site.new
  end

  def create
    @site = Site.create_site(current_user)
    
    if @site.save
      redirect_to @site
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @site = Site.find(params[:id])
  end
  
end
