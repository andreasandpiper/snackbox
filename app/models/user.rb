class User < ApplicationRecord
    has_many :participation
    
    validates_uniqueness_of :email

    validates :email, presence: true, format: { with: /\A[A-Za-z0-9+_.-]+@(teladochealth.com)\z/, on: :create, message: 'Please sign up using Teladoc Health company email address.' }
end