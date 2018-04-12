@students = [] # an empty array accessible to all methods
@months = ["january", "february", "march", "april", "may", "june", "july",
  "august", "september", "october", "november", "december"]

def interactive_menu
  loop do
  print_menu
    process(STDIN.gets.chomp)
  end
end

def success(selection)
  puts "Selection #{selection} was successful"
end

def process(selection)
  case selection
    when "1"
      success(selection)
      input_students
    when "2"
      success(selection)
      show_students
    when "3"
      success(selection)
      save_students
    when "4"
      success(selection)
      load_students
    when "9"
      success(selection)
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
  name = STDIN.gets.strip
  while !name.empty? do
    puts "Which cohort are they on?"
    cohort = STDIN.gets.strip.downcase.to_sym
    while !@months.any? { |month| cohort.to_s.include?(month) } do
      puts "Please input the correct cohort or leave blank to automate"
      cohort = STDIN.gets.strip.downcase.to_sym
      if cohort.empty?()
        cohort = :april
      end
    end
    add_students(name, cohort)
    if @students.count < 2
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    name = STDIN.gets.strip
  end
  @students
end

def input_cohort

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
  puts "Which file would you like to save to?"
  filename = STDIN.gets.chomp
  if filename == ""
    puts "Sorry you did not enter a file name"
  else
    file = File.open(filename,"w")
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    puts "You have saved as #{filename}"
  file.close
end
end

def load_students
  puts "Which file would you like to load?"
  filename = STDIN.gets.chomp
  check_filename(filename)
end

def try_load_students
  filename = ARGV.first
  check_filename(filename)
end

def check_filename(filename)
  if filename.nil?
    filename = "students.csv"
    copy_file(filename)
    puts "Loaded #{@students.count} from students.csv"
  elsif File.exists?(filename)
    copy_file(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def copy_file(filename)
  file = File.open(filename,"r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_students(name, cohort)
  end
  file.close
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

try_load_students
interactive_menu
