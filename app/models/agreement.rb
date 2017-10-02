class Agreement < ApplicationRecord
 belongs_to :text
 validates :client_name, presence: true
 validates :description, presence: true
end
