class User < ApplicationRecord
  #バリデーションテストファイルで.valid?で呼び出せる。
  before_save { self.email = email.downcase } #データベースに渡す前にメールアドレスを全て小文字にする。データベースアダプタの中に大文字小文字を区別できないバカがいる。
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, #存在することと長さ。
                    format: { with: VALID_EMAIL_REGEX }, #メールアドレスの表記に則っている
                    uniqueness: { case_sensitive: false } #大文字小文字の差を無視する
  has_secure_password #安全なパスワードを持っているぞ。
  validates :password, presence: true, length: { minimum: 6 } #パスワードがちゃんと存在して、長さの最小が6
  def User.digest(string)   ###今後テストなどでログインのパスワードを仮に発行したいときに用いる。
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザー（記憶トークン）をデータベース（記憶ダイジェスト）に記憶する
  def remember
    self.remember_token = User.new_token   ###ハッシュ化した記憶トークンをremembe_token属性(インスタンス変数)に代入する。
    update_attribute(:remember_digest, User.digest(remember_token))
  end
end
