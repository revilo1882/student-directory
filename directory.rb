def months
  months = ["january", "february", "march", "april", "may", "june", "july",
    "august", "september", "october", "november", "december"]
end

def input_students(months)
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice after name is requested"
  students = []
  name = gets.strip
  while !name.empty? do
    puts "Which cohort are they on?"
    cohort = gets.strip.downcase.to_sym
    while !months.any? { |month| cohort.to_s.include?(month) } do
      puts "Please input the correct cohort or leave blank to automate"
      cohort = gets.strip.downcase.to_sym
      if cohort.empty?()
        cohort = :april
      end
    end
    students << {name: name, cohort: cohort, country_of_birth: :england}
    if students.count < 2
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    name = gets.strip
  end
  students
end

def print_header
  puts "The students of Villians Academy".center(60)
  puts "-------------".center(60)
end

def print(students, months)
  months.each do |month|
    puts "The #{month.capitalize} cohort includes:
    "
    students.each do |student|
      if student[:cohort] == month.to_sym
        puts "#{student[:name].capitalize}".center(60)
      end
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(60)
end

students = input_students(months)
exit if students.empty?
print_header
print(students, months)
print_footer(students)
