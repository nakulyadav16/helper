class User < ApplicationRecord
  belongs_to :department 
  has_many :tickets,dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :name, presence: true , message: "name is blank it can't"
  # validates_presence_of :name, :message => 'Please Enter Your Name.'
  validates_presence_of :name

  validates :contact,  presence: true , length: { minimum: 10 }
  validates :department_id, presence: true
  validates :dob, presence: true 
  validate :check_age

  private
    def check_age
      if(dob != nil)
          if(Date.today.year - dob.year)<=18
            self.errors.add(:base," must be greater than 18.")
          end
      end 
  end
end