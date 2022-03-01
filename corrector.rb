class Corrector
    def correct_name(name)
        correct_name = name.downcase
        correct_name = name.capitalize
        if name.size > 10
            correct_name =  name.slice(0,10)
        end
        correct_name
    end    
end

