class User < ApplicationRecord
  belongs_to :attr

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :addr,
     presence: true,
     length: { maximum: 255 },
     format: { with: VALID_EMAIL_REGEX }
#     uniqueness: { case_sensitive: false }
  validate :addr_unique

  def encryptor
     secret = Rails.application.secrets.secret_key_base
     ::ActiveSupport::MessageEncryptor.new(secret)
   end

   def addr=(val)
     encryptor = self.encryptor
     write_attribute("addr", encryptor.encrypt_and_sign(val))
   end

   def addr
     encryptor = self.encryptor
     encryptor.decrypt_and_verify(read_attribute("addr"))
   end

  private
    def addr_unique
      if User.where(addr: addr, status: 1).exists?
        errors.add("メールアドレス", 'はすでに登録されています')
      end
    end
    def status_unique
      if User.where(status: 1, attr_id: attr_id).exists? && status == 1
        errors.add("この", '座席はすでに埋まってしまいました')
      end
    end
end
