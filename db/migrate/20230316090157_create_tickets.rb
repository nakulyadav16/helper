class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :description
      t.date :due_date
      t.string :priority
      t.bigint :assigned_to
      t.references :user, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
