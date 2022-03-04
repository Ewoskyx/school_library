#!/usr/bin/env ruby

# Imports
require 'pry'
require './book'
require './student'
require './teacher'
require './rental'

# Opener
puts "---------------------------------\n
 Welcome to School Library App!\n
 ------------------------------"

# State Helpers
@book_arr = []
@person_arr = []

def book_store(book)
  @book_arr.push(book)
  @book_arr
end

def person_store(person)
  @person_arr.push(person)
  @person_arr
end

def create_student
  print 'Age: '
  age = gets.chomp
  print 'Name: '
  name = gets.chomp
  print 'Has parent permission? [Y/N]: '
  perm_input = gets.chomp
  case perm_input.upcase
  when 'Y'
    perm = true
  when 'N'
    perm = false
  else
    puts 'Wrong input!'
    init
  end
  student = Student.new(age, name)
  student.parent_permission = perm
  student.type = 'Student'
  person_store(student)
  success('Person')
end

def create_teacher
  print 'Age: '
  age = gets.chomp
  print 'Name: '
  name = gets.chomp
  teacher = Teacher.new(age, name)
  print 'Specialization: '
  specialization = gets.chomp
  teacher.specialization = specialization
  teacher.type = 'Teacher'
  person_store(teacher)
  success('Person')
end

# Formatters
def success(item)
  puts "#{item} created succesfully!"
end

# Menu Operations
def list_all_books
  @book_arr.map { |book| puts "Title: \"#{book.title}\" Author: #{book.author}" }
  init
end

def list_all_people
  @person_arr.map { |person| puts "[#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
  init
end

def create_a_person()
  puts 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
  option = gets.chomp
  case option.to_i
  when 1
    create_student
  when 2
    create_teacher
  else
    puts 'Wrong input !'
  end
  init
end

def create_a_book
  print 'Title: '
  title = gets.chomp
  print 'Author: '
  author = gets.chomp
  book = Book.new(title, author)
  book_store(book)
  success('Book')
  init
end

def create_a_rental
  puts 'Select a book from the following list by number'
  @book_arr.each_with_index { |book, idx| puts "#{idx}) Title: \"#{book.title}\" Author: #{book.author}" }
  book_index = gets.chomp.to_i
  puts 'Select a person from the following list by number (not id)'
  @person_arr.each_with_index do |person, idx|
    puts "#{idx}) [#{person.type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  end
  person_index = gets.chomp.to_i
  print 'Date (yyyy/mm/dd): '
  date = gets.chomp
  person = @person_arr[person_index]
  book = @book_arr[book_index]
  Rental.new(date, person, book)
  success('Rental')
  init
end

def list_rentals_for_id
  print 'ID of person: '
  person_id = gets.chomp.to_i
  person = @person_arr.find { |prsn| prsn.id == person_id }
  rental = person.rentals
  puts 'Rentals:'
  rental.each do |item|
    puts "Date: #{item.date}, Book: #{item.book.title}, by #{item.book.author}"
  end
  init
end

def exit
  puts 'Thank you for using School Library app!'
end

# Menu
def menu
  puts "\nPlease choose an option by entering a number:"
  puts '1 - List all books', '2 - List all people', '3 - Create a person', '4 - Create a book',
       '5 - Create a rental', '6 - List all rentals for a given person id', '7 - Exit'
end

# Menu Selections
@menu_hash = { 1 => method(:list_all_books), 2 => method(:list_all_people), 3 => method(:create_a_person),
               4 => method(:create_a_book), 5 => method(:create_a_rental),
               6 => method(:list_rentals_for_id), 7 => method(:exit) }
def init()
  menu
  selection = gets.chomp
  if selection.positive? && selection <= 7
    @menu_hash[selection].call
  else
    puts 'Wrong input !'
  end
end

init
