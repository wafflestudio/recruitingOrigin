class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.column "title", :string
      t.column "question_type", :integer
      t.column "items", :text
      t.column "priority", :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
