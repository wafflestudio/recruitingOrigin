class ApplicationController < ActionController::Base
  protect_from_forgery

  @@current_order = 8

  def is_recruiting_period?
      #redirect_to signin_recruit_index_path
  end

  def authorized?
    if session[:applicant] == nil
      redirect_to signin_recruit_index_path
    end
  end

  def admin?
    if session[:admin] == nil
      redirect_to admin_login_path
    end
  end
end

