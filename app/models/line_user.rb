class LineUser < ApplicationRecord
  belongs_to :user
  
  validates :line_user_id, presence: true
end
