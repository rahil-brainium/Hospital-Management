class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :address, as: :addressable
  belongs_to :organisation
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :prescriptions
  has_attached_file :avatar,:styles => { thumb: '100x100>' }, default_url: "/images/:style/missing.png",:processors => [:cropper]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  #validates :name,:email,:role,:sex,:phone,presence: true
  #validates :phone , numericality: { only_integer: true, message: "Input integer only" }
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  after_update :reprocess_avatar, :if => :cropping?

  scope :receptionists,-> { where(:role => 'receptionist') }
  scope :doctors,-> { where(:role => 'doctor') }




  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  private
  def reprocess_avatar
    # debugger
    self.avatar.reprocess!
  end
end
