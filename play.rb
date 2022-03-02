require './Classroom'
require './Student'
require './Person'
require './Book'
require './Rental'

# Classroom -> Student (has-many / belongs-to)
my_classroom = Classroom.new('Ruby Class')
std1 = Student.new(42, 'Evren')
std2 = Student.new(22, 'Alen')
my_classroom.add_students(std1)
my_classroom.add_students(std2)

# A classroom has many students
case1 = my_classroom.students.map(&:name)
puts "Class number 1 has students #{case1}"
# A student belongs to a classroom
case2 = std2.classroom.label
puts "Student 2 belongs to the classroom #{case2}"

# Book -> Rental <- Person (Many to Many)
book1 = Book.new('The Lord of The Rings', 'Tolkien')
book2 = Book.new('Some Book', 'Some Author')

rent1 = Rental.new('2022-3-1', std2, book1)
rent2 = Rental.new('2022-3-2', std2, book2)
rent3 = Rental.new('2022-3-1', std1, book2)

# A book has many rentals
case3 = book2.rentals.map { |rental| rental.person.name }
puts "Book 2 is rented by students #{case3}"
# A rental belongs to a book
case4 = rent1.book.title
puts "Rentlal 1 belongs to the book #{case4}"

# A person has many rentals
case5 = std2.rentals.count
puts "Person 2 has #{case5} rentals"
# A rental belongs to a book
case6 = rent3.person.name
puts "Rental 3 belongs to person #{case6}"
case7 = rent2.person.name
puts "Rental 2 belongs to person #{case7}"

# The person itself should be sent as a parameter to create the new rental achieving the 'has-many' association
std1.add_rental(book1, "2022-3-3")
case8 = std1.rentals.last.book.title
puts "Student 1 did rent #{case8} by using add_rental method"
