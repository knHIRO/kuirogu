class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :posting
  has_many :notifications, dependent: :destroy
end
