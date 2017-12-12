class UserAgreement < ApplicationRecord
  belongs_to :user
  belongs_to :agreement
end
