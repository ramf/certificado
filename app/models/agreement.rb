class Agreement < ApplicationRecord
 belongs_to :text
 validates :client_name, presence: true
 validates :description, presence: true
 validates :email, presence: true
end
