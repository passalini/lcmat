# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :professor
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates_presence_of :password_confirmation, if: lambda { password.present? }
end
