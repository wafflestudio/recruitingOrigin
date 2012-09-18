class AddOrderToApplicants < ActiveRecord::Migration
  def self.up
    add_column :applicants, :order, :integer
  end

  def self.down
    remove_column :applicants, :order
  end
end
