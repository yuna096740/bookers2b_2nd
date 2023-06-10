class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
   validates:title,presence:true
   validates:body,presence:true,length:{maximum: 200 }

   def favorited_by?(user)
     favorites.exists?(user_id: user.id)
   end

  def self.search(keyword)
    where(["title LIKE? OR body LIKE?", "%#{keyword}%", "%#{keyword}%"])
  end

  scope :created_this_week, -> { where(created_at: 6.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  scope :created_each_date, -> (date){ where(created_at: date.days.ago.all_day) }
  def self.book_week_count
    (0..6).map { |date| created_each_date(date).count }.reverse
  end
end
