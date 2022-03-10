ActiveAdmin.register Site do
  actions :all, except: [:edit]

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :php_version, :wp_version, :admin_username, :admin_password, :status, :account_id, :category, :name, :db_username, :db_password
  #
  # or
  #
  # permit_params do
  #   permitted = [:php_version, :wp_version, :admin_username, :admin_password, :status, :account_id, :category, :name, :db_username, :db_password]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
