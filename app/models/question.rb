# coding:utf-8
class Question < ActiveRecord::Base
  serialize :items
#  serialize :recruit_order

  def type_name
    ["주관식", "객관식", "중복선택"][self.question_type-1]
  end

  def self.type_select_options
    [["주관식",1], ["객관식", 2], ["중복선택", 3]]
  end
end
