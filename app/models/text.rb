class Text < ApplicationRecord  
  validates :shortdescription, presence: true
  validates :description, presence: true
end
