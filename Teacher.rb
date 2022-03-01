require "./Person.rb"
class Teacher < Person
    def initialize(name="Unknown", age, parent_permission= true, specialization)
        @specialization = specialization
    end

    def can_use_services?
       true
    end
end