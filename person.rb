require './corrector'

class Person
  attr_accessor :name, :age, :type
  attr_reader :id, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1...1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @corrector = Corrector.new
    @rentals = []
    @type = type
  end

  def validate_name(name)
    @name = @corrector.correct_name(name)
  end

  def can_use_services?
    if of_age? || @parent_permission
      true
    else
      false
    end
  end

  def add_rental(book, date)
    Rental.new(date, self, book)
  end

  private

  def of_age?
    @age >= 18
  end
end
