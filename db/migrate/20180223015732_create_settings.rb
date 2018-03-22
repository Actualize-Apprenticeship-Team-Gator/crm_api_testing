class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.integer :admin_id
      t.text :auto_text_content

      t.timestamps
    end
  end
end
