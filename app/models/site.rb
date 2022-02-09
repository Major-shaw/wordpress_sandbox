class Site < ApplicationRecord
  belongs_to :account, optional: true

  def self.create_site(current_user)
    @site = Site.new(
      php_version: '7.4',
      wp_version: '5.7.2',
      admin_username: 'admin',
      admin_password: SecureRandom.hex(8),
      name: site_name,
      account_id: find_account(current_user)
    )
  end

  def self.site_name
    return LiterateRandomizer.word + rand(10000).to_s
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
end
