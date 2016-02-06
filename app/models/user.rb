class User < ActiveRecord::Base
	has_secure_password
	has_many :articles
validates :user_name, presence: true, uniqueness: {case_sensitive: false},  length: {minimum: 3, maximum: 25}
validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 25 }

end