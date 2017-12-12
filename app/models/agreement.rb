class Agreement < ApplicationRecord

  has_many :user_agreements
  has_many :users, through: :user_agreements


 belongs_to :text
 validates :client_name, presence: true
 validates :description, presence: true
 validates :email, presence: true
end
