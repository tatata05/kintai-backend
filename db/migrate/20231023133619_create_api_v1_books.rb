class CreateApiV1Books < ActiveRecord::Migration[6.1]
  def change
    create_table :api_v1_books do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
