class User < ApplicationRecord
  belongs_to :attr

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :addr,
     presence: true,
     length: { maximum: 255 },
     format: { with: VALID_EMAIL_REGEX }
#     uniqueness: { case_sensitive: false }
  validate :addr_unique

  private
    def addr_unique
      if User.where(addr: addr, status: 1).exists?
        errors.add(:addr, 'すでに予約が完了したアドレスです')
      end
    end

end
