class Profile < ApplicationRecord

    validates :name, presence: true
    validates :description, presence: true

    has_many :profile_activities
    has_many :users
    has_many :activities, :through => :profile_activities
end
