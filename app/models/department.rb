class Department < ApplicationRecord
    before_create { |department| department.department_name = department.department_name.capitalize }
    has_many :users, dependent: :destroy
end
