class CreateUserAgreements < ActiveRecord::Migration[5.1]
  def change
    create_table :user_agreements do |t|
      t.references :user, foreign_key: true
      t.references :agreement, foreign_key: true
    end
  end
end
