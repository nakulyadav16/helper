class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :name, presence: true , message: "name is blank it can't"
  validates_presence_of :name, :message => 'Please Enter User  Name.'

  validates :contact,  presence: true
  validates :email, presence: true
  validates :department_id, presence: true

  belongs_to :department 
  has_many :tickets,dependent: :destroy
end
