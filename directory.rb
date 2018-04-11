def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice after name is requested"
  students = []
  months = ["january", "february", "march", "april", "may", "june", "july",
    "august", "september", "october", "november", "december"]
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

def print(students)
  months = {}
  students.each do |student|
    name = "#{student[:name].capitalize} "
    cohort = " Students in the #{student[:cohort].to_s.capitalize} cohort:"
    if months[cohort] == nil
      months[cohort] = name
    else
      months[cohort] << name
    end
  end
months.each { |key| puts key }
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(60)
end

students = input_students
exit if students.empty?
print_header
print(students)
print_footer(students)
