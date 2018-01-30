class AddNameToAgreement < ActiveRecord::Migration[5.1]
  def change
    add_column :agreements, :name, :string
  end
end
