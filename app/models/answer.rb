class Answer < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :question
  validates :content, :presence => true
end
