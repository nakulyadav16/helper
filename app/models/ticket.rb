class Ticket < ApplicationRecord
  include AASM 

  aasm do
    state :opened,initial: true
    state :inprogress , :rejected , :pending , :closed , :reopened

    event :accepted do 
      transitions from: [:opened , :reopened ] , to: :inprogress
    end

    event :rejected do 
      transitions from: [ :opended , :reopened ] , to: :rejected
    end

    event :after_due_date do 
      transitions from: [ :inprogress ] , to: :pending
    end

    event :satisfied do 
      transitions from: [ :inprogress , :pending ] , to: :closed
    end

    event :upgrade do 
      transitions from: [:pending , :inprogress, :rejected , :closed ] , to: :reopened
    end

    event :close do 
      transitions from: [:opended , :reopened , :rejected ] , to: :closed
    end

  end



  validates :subject ,:description ,:department_id, :assigned_to,:due_date, :priority , presence: true
  has_many :messages , dependent: :destroy
  belongs_to :user  
  belongs_to :department 
end

