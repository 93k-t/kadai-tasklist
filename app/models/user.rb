class User < ApplicationRecord
  # Userインスタンス(レコード)を保存する前に文字を全て小文字に変換する
  before_save {self.email.downcase!}
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                    uniqueness: {case_sensitive: false}
  
  has_secure_password
  has_many :tasks
end