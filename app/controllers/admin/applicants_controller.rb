# coding:utf-8
class Admin::ApplicantsController < Admin::AdminController
  before_filter :is_current_order?, :only => [:show]
  
  def index
    @applicants = Applicant.where(:order => @@current_order).reverse.paginate :per_page => 30, :page => params[:page], 
    	:joins => 'answers', 
    	:conditions => 'answers.applicant_id  = id and answers.question_id = 2',
    	:select => 'applicants.*, answers.content as answer',
    	:order => 'answer'

    @questions = Question.where(:order => @@current_order).all
  end

  def show
    @questions = Question.where(:order => @@current_order)
    @applicant = Applicant.find(params[:id])
  end
=begin
  def destroy
    @applicant = Applicant.find(params[:id])
    @applicant.destroy

    redirect_to admin_applicants_path

  end
=end
protected

  def is_current_order?
    @applicant = Applicant.find(params[:id])
    if @applicant.order == @@current_order
      true
    else
      redirect_to admin_applicants_path
      false
    end

  end

end
