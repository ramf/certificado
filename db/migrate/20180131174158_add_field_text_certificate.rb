class AddFieldTextCertificate < ActiveRecord::Migration[5.1]
  def change
    add_column :certificates, :text_id, :integer
  end
end
