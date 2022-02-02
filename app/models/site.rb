class Site < ApplicationRecord
  belongs_to :account, optional: true
  validates :php_version, presence: true
  validates :wp_version, presence: true

  VALID_PHP_VERSIONS = ['v1', 'v2', 'v3']
  VALID_WP_VERSIONS = ['v1', 'v2', 'v3']
  VALID_STATUSES = ['running', 'deleted']

  validates :php_version, inclusion: {in: VALID_PHP_VERSIONS}
  validates :wp_version, inclusion: {in: VALID_WP_VERSIONS}
  validates :status, inclusion: {in: VALID_STATUSES}

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
