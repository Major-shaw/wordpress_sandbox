class SitesController < ApplicationController

  def new
    @site = Site.new
  end

  def create
    account_id = Site.find_account(current_user)

    @site = Site.new(site_params.merge(admin_username: self.create_admin_username(),
                                      admin_password: self.create_admin_password(),
                                      url: self.create_url(),
                                      account_id: account_id))
    
    if @site.save
      redirect_to @site
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @site = Site.find(params[:id])
  end
  
  private
    def create_admin_password
      return ('0'..'z').to_a.shuffle.first(8).join
    end

    def create_admin_username
      return ('a'..'z').to_a.shuffle.first(8).join
    end

    def create_url
      return 'https://something.com'
    end

    def site_params
      params.require(:site).permit(:php_version, :wp_version)
    end
end
