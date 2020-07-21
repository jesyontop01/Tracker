class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         #, :validatable, :jwt_authenticatable,jwt_revocation_strategy: JWTBlacklist

         extend FriendlyId
         friendly_id :email, use: [:slugged, :finders]
         
         belongs_to :office


         after_create :generate_api_token

         private
         def generate_api_token
         	self.api_token = Devise.friendly_token
         	self.save
         end

end
