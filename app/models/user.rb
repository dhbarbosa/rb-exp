class User < ApplicationRecord
  has_many :user_cid
  has_many :cids, through: :user_cid
end
