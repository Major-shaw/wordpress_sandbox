class User < ApplicationRecord
  after_create :create_account

  has_one :account, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
  def create_account
    Account.create(user_id: self.id)
  end

end
