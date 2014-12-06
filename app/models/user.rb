# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  is_admin               :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
  # validates_presence_of :name, :email, unless: :guest?
  # validates_uniqueness_of :name, allow_blank: true
  # validates_confirmation_of :password

  has_many :ads, dependent: :destroy
  has_many :post, dependent: :destroy

  # override has_secure_password to customize validation until Rails 4.
  # require 'bcrypt'
  # attr_reader :password
  # include ActiveModel::SecurePassword::InstanceMethodsOnActivation

  def admin?
    is_admin
  end  

  # def self.new_guest
  #   new { |u| u.guest = true }
  # end
  
  # def name
  #   guest ? "Guest" : name
  # end

end
