class User < ApplicationRecord
    has_many :participation
    
    validates_uniqueness_of :email

    validates :email, format: { with: /\A[A-Za-z0-9+_.-]+@(teladochealth.com)\z/, on: :create }
end