require 'csv'
require 'pry'

class Student
  attr_accessor :name, :grades

  def initialize
    @name = name
    @grades = grades
    @grades = []
    enter_name
    enter_grades
  end

  def enter_name
    puts 'Enter student\'s name:'
    @name = gets.chomp
  end

  def enter_grades
    puts 'Enter student\'s grades:'
    grade = gets.chomp
    while grade.length > 0
      @grades.push(grade)
      grade = ''
      enter_grades
    end
  end
end

class StudentReport
  attr_accessor :report

  def initialize
    @report = report
    @report = []
    add_students
  end

  def add_students
    @student = Student.new
    @report << @student

    @formatted = @student.name.to_s + ',' + @student.grades.join(',')
    to_csv
    puts 'Add another student? (y/n)'
    @add_student = gets.chomp

    if @add_student == 'y'
      add_students
    end
  end

  def to_csv
    File.open('ta.txt', 'a') do |f|
      f.puts @formatted
    end
  end
end

class StudentReportAnalytics
  def initialize
    print_analytics
  end

  def find_average
    @sum = 0
    @average_array.each { |x| @sum = @sum + x }
    @student_average = @sum / @average_array.length
    puts "#{@student_name}: average score -- #{@student_average}"
  end

  def print_analytics
    File.foreach('example.txt') do |l|
      CSV.parse(l)
      @average_array = l.chomp.split(',')
      @student_name = @average_array.shift
      @average_array.map! { |i| i.to_i }
      find_average
    end
  end

end

report = StudentReport.new
analytics = StudentReportAnalytics.new

# GIT "REPORT OUT"
# want to know a student's average
#   - output each student's name and average score

# GIT "ASSIGN A LETTER GRADE"
# want to know every student's final letter grade
#   - take average score, map it to a letter grade
#     >= 90 == "A"
#     >= 80 == "B"
#     >= 70 == "C"
#     >= 60 == "D"
#     <= 60 == "F"
#   - output each student's letter grade

# GIT "WRITE A TEXT FILE WITH GRADE DETAIL"
# output final letter grade to a file
#   - sorted last name to first
#   - file contains average score (rounded to first decimal) and letter grade

# GIT "REPORT OUT AGGREGATE INFO"
# output course analytics
#   - output average score, min score, max score and standard deviation across the class