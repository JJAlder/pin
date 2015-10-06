class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 has_many :pins, dependent: :destroy
 has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png", :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename" 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
 validates :name, uniqueness: true
 def full_name
    if self.name.blank?
      self.email
    else
      self.name
    end
  end

end
