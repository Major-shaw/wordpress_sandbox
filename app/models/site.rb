class Site < ApplicationRecord
  belongs_to :account, optional: true

  VALID_STATUSES = ['running', 'deleted']
  VALID_CATEGORIES = ['permanent', 'temporary']

  validates :status, inclusion: {in: VALID_STATUSES}
  validates :category, inclusion: {in: VALID_CATEGORIES}

  def self.create_site(current_user)
    @site = Site.new(
      php_version: 'v1',
      wp_version: 'v1',
      admin_username: 'admin',
      admin_password: SecureRandom.hex(8),
      url: 'something.com',
      account_id: find_account(current_user),
      category: find_category(current_user),
    )
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

end
