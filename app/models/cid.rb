class Cid < ApplicationRecord
  has_many :user_cid
  has_many :users, through: :user_cid
end
