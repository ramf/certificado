class Student < ApplicationRecord

  has_many :user_students
  has_many :users, through: :user_students


 belongs_to :text
 #validates :client_name, presence: true
 validates :description, presence: true
 validates :email, presence: true
 validates :name, presence: true

end
