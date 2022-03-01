class Corrector
  # def correct_name(name)
  #   correct_name = name.capitalize
  #   correct_name = name.slice(0, 10) if name.size > 10
  #   correct_name
  # end
  def correct_name(name)
    name.gsub(name[0], name[0].upcase)[0, 10]
  end
end
