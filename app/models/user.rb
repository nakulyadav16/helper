class User < ApplicationRecord
  rolify

  after_create :assign_role

  attr_accessor :role

  belongs_to :department 
  has_many :tickets,class_name: 'Ticket' ,foreign_key: 'creator_id' ,dependent: :destroy
  has_many :assigned_tickets,class_name: 'Ticket' ,foreign_key: 'assigned_to_id' ,dependent: :destroy
  has_many :messages , through: :tickets

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # validates :name, presence: true , message: "name is blank it can't"
  # validates_presence_of :name, :message => 'Please Enter Your Name.'
  validates :name, presence: true
  validates :contact,  presence: true 
  validates :department_id, presence: true
  validates :dob, presence: true 
  validate :check_age

  private

  def assign_role
    byebug
    self.add_role role
    puts role
  end

  def check_age
    if(dob != nil)
        if(Date.today.year - dob.year)<=18
          self.errors.add(:base," must be greater than 18.")
        end
    end 
  end
end