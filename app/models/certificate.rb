class Certificate < ApplicationRecord

  has_many :user_certificates
  has_many :users, through: :user_certificates


 belongs_to :text
 #validates :client_name, presence: true
 validates :description, presence: true
 validates :email, presence: true
 validates :name, presence: true

end
