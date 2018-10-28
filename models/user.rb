class User < ActiveRecord::Base
    has_many :connections
    has_many :tweets, through: :connections
end