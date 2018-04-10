def input_students
  months = ["january", "february", "march", "april", "may", "june", "july",
              "august", "september", "october", "november", "december"]
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
    students << {name: name, cohort: cohort}
    if students.count < 2
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    name = gets.strip
  end
  #return the array of students
  students
end

def print_header
  puts "The students of Villians Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  count = 0
  while count < students.count
    if students[count][:name].downcase.start_with?("o") &&
      students[count][:name].length < 12
      puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)".center(50)
    end
    count += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

students = input_students
exit if students.empty?
#nothing happens until we call the methods
print_header
print(students)
print_footer(students)
