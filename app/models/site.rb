class Site < ApplicationRecord
  belongs_to :account, optional: true
  validates :wp_version, presence: true
  validates :php_version, presence: true

  VALID_WP_VERSIONS = ['latest', '5.6.8']
  VALID_PHP_VERSIONS = ['7.4', '8.1']
  
  def self.create_site(current_user, ip, wp_version, php_version)
    if current_user
      ip = ''
    end
    db_hex = SecureRandom.hex(8)
    site = Site.new(
      php_version: php_version,
      wp_version: wp_version,
      admin_username: 'admin',
      admin_password: SecureRandom.hex(8),
      account_id: find_account(current_user),
      category: find_category(current_user),
      name: site_name,
      db_username: 'wp_db_' + db_hex,
      db_password: 'wp_db_pass' + db_hex,
      client_ip: ip)  
    site.save
    Server_job.perform(site.id)
    site
  end

  def self.site_name
    return LiterateRandomizer.word.downcase.delete('-') + rand(1000).to_s
  end

  def self.find_account(current_user)
    if current_user
      account = Account.find_by user_id: current_user.id
      account_id = account.id
    else
      return nil
    end
    return account_id
  end

  def self.find_category(current_user)
   return 'permanent' if current_user != nil
   return 'temporary'
  end

  def self.delete(site)
    response = RestClient::Request.execute(method: :delete, url: 'http://206.189.138.203:47157',payload: site.to_json,
                                           headers: {"Content-Type" => "application/json"})
    return response.code
  rescue Errno::ECONNREFUSED
    return 500
  rescue RestClient::ExceptionWithResponse => e
   return e.response.code
  rescue Net::HTTPBadResponse => e
    return 200
  end




end
