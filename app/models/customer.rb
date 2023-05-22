class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # 論理削除用のスコープを設定
  default_scope { where(is_deleted: false) }
  # 退会処理を実行するメソッド
  def withdraw
    update(is_deleted: true)
  end
  
  # ログイン時に退会済みのユーザーがログインできないようにする
  def active_for_authentication?
    super && !is_deleted
  end

  has_many :recipes, dependent: :destroy
  # has_many :foos, dependent: :destroy, class_name: 'Recipe'
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe

  def self.looks(search, word)
    @customer = Customer.where("family_name LIKE ? OR personal_name LIKE ?", "%#{word}%", "%#{word}%")
  end
  
  def self.guest
    find_or_create_by!(family_name: 'guestuser' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
  
  enum status: { 有効: true, 退会: false }
  def inactive?
    !status
  end
end
