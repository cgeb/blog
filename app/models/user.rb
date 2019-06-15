class User < ApplicationRecord
  has_secure_password 

  has_many :articles, :foreign_key => 'author_id'
end