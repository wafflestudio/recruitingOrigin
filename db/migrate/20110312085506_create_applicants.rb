class CreateApplicants < ActiveRecord::Migration
  def self.up
    create_table :applicants do |t|
      t.column "name", :string
      t.column "organization", :string
      t.column "phone", :string
      t.column "email", :string
      t.column "password_salt", :string
      t.column "password_hash", :string
      t.timestamps
    end
  end

  def self.down
    drop_table :applicants
  end
end
