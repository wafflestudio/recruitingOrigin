class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.column "applicant_id", :integer, :null => false
      t.column "question_id", :integer, :null => false
      t.column "content", :text
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
