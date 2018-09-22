class User < ApplicationRecord
  has_secure_password
  
   before_save { self.email = email.downcase }
   
   has_secure_password
   
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   
   validates :email, 
			presence: true, 
			uniqueness: true,
			format: {with: VALID_EMAIL_REGEX},
			length: { maximum: 255 },
			confirmation: { case_sensitive: false }

   validates :name, 
			presence: true, 
			uniqueness: true,
			length: {minimum: 2, maximum:30},
			confirmation: { case_sensitive: false }
			
   validates :password, 
			presence: true, 
			length: {minimum: 8}

  has_many :chat_users, dependent: :destroy
  has_many :messages, dependent: :destroy

end
