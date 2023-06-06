class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached:profile_image
  has_many:books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #(フォローする側から、)中間テーブルを通して、フォローされる側を取得する
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  #(フォローされる側から、)中間テーブルを通して、フォローしてくる側を取得する
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id",dependent: :destroy

  #自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしている人
  has_many :follower_user, through: :followed, source: :follower

  validates:name,presence:true,uniqueness:true,length:{ in: 2..20 }
  validates:introduction,length:{ maximum: 50 }
  validates:email,uniqueness:true

  def icon(width,height)
    unless profile_image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     profile_image.attach(io:File.open(file_path),filename:'no_image.jpg',content_type:'image/ipeg')
    end
    profile_image.variant(resize_to_limit:[width,height]).processed
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

end
