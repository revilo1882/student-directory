@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
  print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
    end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice after name is requested"
  months = ["january", "february", "march", "april", "may", "june", "july",
    "august", "september", "october", "november", "december"]
  name = STDIN.gets.strip
  while !name.empty? do
    puts "Which cohort are they on?"
    cohort = STDIN.gets.strip.downcase.to_sym
    while !months.any? { |month| cohort.to_s.include?(month) } do
      puts "Please input the correct cohort or leave blank to automate"
      cohort = STDIN.gets.strip.downcase.to_sym
      if cohort.empty?()
        cohort = :april
      end
    end
    @students << {name: name, cohort: cohort, country_of_birth: :england}
    if @students.count < 2
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    name = STDIN.gets.strip
  end
  @students
end

def print_header
  puts "The students of Villians Academy".center(60)
  puts "-------------".center(60)
end

def print_students_list
  months = {}
  @students.each do |student|
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

def print_footer
  puts "Overall, we have #{@students.count} great students".center(60)
end

def save_students
  file = File.open("students.csv","w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open("students.csv","r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
