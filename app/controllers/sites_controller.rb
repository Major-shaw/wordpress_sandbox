class SitesController < ApplicationController
  skip_before_action :verify_authenticity_token

  @limit = false
  def index
    @sites = Site.all
  end

  def create
    if !current_user and !verify_recaptcha
      redirect_to root_url, notice: "ReCAPTCHA verification failed!"
      return
    end
    begin
      ip = client_ip()
      if limit_reached(current_user, ip, )
        #redirect_to root_url, notice: "limit_reached"
        redirect_to root_path(:error => "limit_reached"), :method => 'post'
        return
      end
      @site = Site.create_site(current_user, ip, params[:site]['wp_version'], params[:site]['php_version'])
      @site.reload

      if @site.status == "deleted"
        redirect_to root_path(:error => "site_not_created"), :method => 'post'
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
      #redirect_to root_path(:delete => "true"), :method => 'post'
      redirect_to root_url, notice: "Successfully Deleted!"
    else
      redirect_to root_url, notice: "Error while deleting site. Try again later."
    end
  end

  private def client_ip
    return request.remote_ip
  end

  private def limit_reached(current_user, ip)
    if not current_user and Site.where(:client_ip => ip, :status => "running").length() >= 2
      return true
    end
  end

end
