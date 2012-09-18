# coding:utf-8
class Admin::QuestionsController < Admin::AdminController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end
  
  def show
    @question = Question.find(params[:id])
  end

  def create
=begin    order_str = params[:question][:recruit_order]
    order_str.gsub!(/\r/,'') unless order_str.nil?
    params[:question][:recruit_order] = order_str.split(/[;\n]/) unless order_str.nil?
=end

    items_str = params[:question][:items]
    items_str.gsub!(/\r/,'') unless items_str.nil?
    params[:question][:items] = items_str.split(/[;\n]/) unless items_str.nil?

    @question = Question.new(params[:question])

    if @question.save 
      redirect_to admin_questions_path
    else
      render new_admin_question_path
    end

  end

  def update
    @question = Question.find(params[:id])
=begin    
    order_str = params[:question][:recruit_order]
    order_str.gsub!(/\r/,'') unless order_str.nil?
    params[:question][:recruit_order] = order_str.split(/[;\n]/) unless order_str.nil?
=end

    items_str = params[:question][:items]
    items_str.gsub!(/\r/,'') unless items_str.nil?
    params[:question][:items] = items_str.split(/[;\n]/) unless items_str.nil?

    if @question.update_attributes(params[:question])
      redirect_to admin_question_path(@question)
    else
      render edit_admin_question_path
    end

  end

  def edit
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to admin_questions_path
  end
end
