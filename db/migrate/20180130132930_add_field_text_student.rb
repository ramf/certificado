class AddFieldTextStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :text_id, :integer
  end
end
