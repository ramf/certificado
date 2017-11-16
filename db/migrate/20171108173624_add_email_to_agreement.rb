class AddEmailToAgreement < ActiveRecord::Migration[5.1]
  def change
    add_column :agreements, :email, :string
  end
end
