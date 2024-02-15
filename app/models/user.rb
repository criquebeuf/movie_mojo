class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :questionnaires, dependent: :destroy
  has_many :watched_movies
  has_many :movies, through: :watched_movies
  has_many :ratings

  before_create :assign_avatar

  # def avatar
  #   if super.nil?
  #     assign_avatar
  #     save
  #     return super
  #   else
  #     super
  #   end
  # end

  private

  def assign_avatar
    self.avatar = random_image_from_folder
  end

  def random_image_from_folder
    folder_path = Rails.root.join('app', 'assets', 'images', 'avatars')
    image_files = Dir.glob("#{folder_path}/*.png")
    image_files.sample.sub("#{Rails.root}/app/assets/images/", "")
  end
end
