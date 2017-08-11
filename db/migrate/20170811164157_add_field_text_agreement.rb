class AddFieldTextAgreement < ActiveRecord::Migration[5.1]
  def change
     add_column :agreements, :text_id, :integer
  end
end
