class CreateAccountCredentials < ActiveRecord::Migration
  def change
    create_table :account_credentials do |t|
      t.integer :account_id
      t.string :identity

      t.timestamps
    end
  end
end
