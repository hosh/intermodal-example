class CreateAccessCredentials < ActiveRecord::Migration
  def change
    create_table :access_credentials do |t|
      t.integer :account_id
      t.string :identity

      t.timestamps
    end
  end
end
