class Course < ApplicationRecord

    has_many: :enrollments,
        primary_key: :id, 
        foreign_key: :course_id, 
        class_name: :enrollments

    has_many: :enrolled_students,
        through: :enrollments,
        source: :student

    has_one: :prequisite, 
        primary_key: :id,
        foreign_key: :prereq_id,
        class_name: :Course

        


end
