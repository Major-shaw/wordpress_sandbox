class Site < ApplicationRecord
  belongs_to :account, optional: true

  def self.create_site(current_user)
    @site = Site.new(
      php_version: '7.4',
      wp_version: '5.7.2',
      admin_username: 'admin',
      admin_password: SecureRandom.hex(8),
      url: create_url,
      account_id: find_account(current_user)
    )
  end

  def self.create_url
    word = LiterateRandomizer.word
    url = 'https://' + word + '.blogvault.com'
    return url if Site.where(:status => "running", :url => url).length() == 0
    create_url
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
