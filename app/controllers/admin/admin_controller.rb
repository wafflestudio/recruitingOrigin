require 'digest/sha1'
class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :authorized?, :except => [:authorize, :login]

  def login
    if session[:admin]
      redirect_to admin_applicants_path
    end
  end

  def authorize
    if check_credential(params[:id], params[:password])
      session[:admin] = params[:id]
    else
      flash[:error] = 'Wrong ID or password'
    end

    redirect_to admin_login_path
  end

  def logout
    session[:admin] =nil
    flash[:notice] = 'Signed out'
    redirect_to admin_login_path
  end

private
  def authorized?
    if !session[:admin]
      redirect_to admin_login_path
    end
  end

  def check_credential(id, password)
    credentials = YAML::load_file("#{Rails.root.to_s}/config/admin.yml") 
    !credentials.find{|c| c[:id] == id and c[:password] == Digest::SHA1::hexdigest(password)}.nil?
  end
end
