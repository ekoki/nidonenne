class User < ApplicationRecord
  authenticates_with_sorcery!
  # 下記がトークンが生成され、usersテーブルに保存される。https://qiita.com/mitz/items/9dbf5017a48f5961a596
  has_secure_token :auth_token
  has_many :notification_settings
  has_many :questions
  has_many :schedules
  has_many :line_users

  validates :name, presence: true, length: { maximum: 15 }
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  private
  
  def own?(object)
    id == object.user_id
  end

  def ensure_auth_token
    if auth_token_created_at < 24.hours.ago
      regenerate_auth_token
      self.auth_token_created_at = Time.current
      save!
    end
  end
  


end
