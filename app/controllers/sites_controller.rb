class SitesController < ApplicationController
  skip_before_action :verify_authenticity_token
  @limit = false
  def index
    @sites = Site.all
  end

  def new
    @site = Site.new
  end

  def create
    begin
      ip = client_ip()
      if limit_reached(current_user, ip)
        redirect_to root_path(:error => "limit_reached"), :method => 'post'
        #redirect_to controller: 'home', action: 'index', error: 'limit_reached'
        #render json: {status: "error", message: "Can't create more than two sites without logging in"}
        return
      end
      @site = Site.create_site(current_user, ip)
      sleep 10.0
      @site.reload

      if @site.status == "deleted"
        render json: {status: "error", code: 500, message: "Unable to create site. Try again later."}
      else
        redirect_to @site
      end

    rescue
      redirect_to root_path
    end

  end

  def show
    @site = Site.find(params[:id])
  end

  def destroy
    @site = Site.find(params[:id])
    response = Site.delete(@site)
    if response == 200
      @site.destroy
      redirect_to root_path(:delete => "true"), :method => 'post'
    else
      render json: {status: "error", message: "can't delete site. Try again later"}
    end
  end


  private def client_ip
    return request.remote_ip
  end

  private def limit_reached(current_user, ip)
    if not current_user and Site.where(:client_ip => ip).length() >= 2
      return true
    end
  end

end
