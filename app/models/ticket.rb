class Ticket < ApplicationRecord

  validates :subject ,:description ,:department_id, :assigned_to,:due_date, :priority , presence: true
  has_many :messages , dependent: :destroy
  belongs_to :user  
  belongs_to :department 
end

