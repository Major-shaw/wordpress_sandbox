class HomeController < ApplicationController

  def index
    @sites = Site.all
    @site = Site.new
  end

end
