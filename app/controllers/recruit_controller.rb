#coding:utf-8
class RecruitController < ApplicationController
  before_filter :shut_down, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :authorized?, :only => [:edit, :update, :destroy, :show, :signout]
  before_filter :set_applicant
  before_filter :is_recruiting_period?, :except => [:index, :signin]

  def shut_down
    redirect_to signin_recruit_index_path if true
  end

  def signin
    redirect_to recruit_path(:id => @applicant.id) unless session[:applicant].nil?
  end

  def index
    redirect_to signin_recruit_index_path
  end

  def signout
    session[:applicant] = nil
    redirect_to signin_recruit_index_path
  end

  def authorize
    @applicant = Applicant.authenticate(params[:id], params[:password])
    
    unless @applicant.nil?
      session[:applicant] = @applicant.id
      flash[:error] = nil;
      redirect_to recruit_path(:id => @applicant.id)
    else
      flash[:error] = "로그인 실패! 이메일이나 비밀번호를 확인하세요"
      redirect_to signin_recruit_index_path
    end
  end

  def new
    @applicant = Applicant.new
    @applicant.answers = []
    @questions = Question.where(:order => @@current_order)
    @questions.each_with_index {|q,i| @applicant.answers << Answer.new(:question_id => q.id)}
  end

  def show
#    @applicant = Applicant.find(params[:id])
    @questions = Question.where(:order => @applicant.order)
  end

  def edit
#    @applicant = Applicant.find(params[:id])
    @questions = Question.where(:order => @applicant.order)
  end

  def update
#    @applicant = Applicant.find(params[:id])
    @applicant.updated_at = Time.now
    if @applicant.update_attributes(params[:applicant]) 
      redirect_to recruit_path(:id => @applicant.id)
    else
      render edit_recruit_path
    end
  end

  def create
    @applicant = Applicant.new(params[:applicant])
    @questions = Question.where(:order => @@current_order)

    pw_confirmed = false
    if params[:password] != "" && !params[:password].nil? && params[:password] == params[:password_confirm]
      pw_confirmed = true
      @applicant.password = params[:password]
    else
      pw_confirmed = false
      @applicant.errors.add(:password, "비밀번호가 일치하지 않습니다.")
    end

    if pw_confirmed && @applicant.save
      unless Applicant.authenticate(@applicant.email, params[:password]).nil?
        session[:applicant] = @applicant.id
      end
      redirect_to recruit_path(:id => @applicant.id)
    else
      render new_recruit_path
    end
  end

  def destroy
#    @applicant = Applicant.find(params[:id])
    @applicant.destroy
    session[:applicant] = nil
    redirect_to signin_recruit_index_path
  end
private 
  def set_applicant
    unless session[:applicant].nil?
      applicant = Applicant.find_by_id(session[:applicant].to_i)
      @applicant = applicant unless applicant.nil?
    end
  end

end
