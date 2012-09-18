require 'digest/sha2'

class Applicant < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers

  validates :email,   
    :presence => true,   
    :uniqueness => true,   
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  
  validates :name, :presence => true
  validates :organization, :presence => true
  validates :phone, :presence => true, :format => { :with => /^01[016789]\-(:?\d{4}|\d{3})\-\d{4}$/ }

  def prev
    self.class.first(:conditions => ["id < ?",id], :order => "id desc")
  end

  def next
    self.class.first(:conditions => ["id > ?",id], :order => "id asc")
  end


  def self.authenticate(email, password)
    applicant = Applicant.where(:email => email).first
    if applicant.nil? || Digest::SHA256.hexdigest(password + applicant.password_salt) != applicant.password_hash
      applicant = nil
    end

    return applicant
  end

  def password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(pass + salt)
  end

end
