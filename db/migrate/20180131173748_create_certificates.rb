class CreateCertificates < ActiveRecord::Migration[5.1]
  def change
    create_table :certificates do |t|
      t.string :name
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
