class Pref < ApplicationRecord
  has_many :user_info

  validates :name, presence: true, length:{ maximum: 64, too_long: "最大%{count}文字まで使用できます"}
end
