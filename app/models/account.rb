class Account < ApplicationRecord
  belongs_to :user
  has_many :sites, dependent: :destroy
end
