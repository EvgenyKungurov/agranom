class User < ApplicationRecord
  after_create :create_user_profile
  has_one :profile, dependent: :destroy
  has_many :ads, dependent: :destroy
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def create_user_profile
    Profile.create(user_id: id)
  end
end
