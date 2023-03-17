class Ticket < ApplicationRecord

  validates :subject ,:description ,:department_id, :assigned_to,:due_date, :priority , presence: true

  belongs_to :user  
  belongs_to :department 
end
