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

report = StudentReport.new

# GIT "LOAD 'EM UP"
# want to load grade data
#   - design a csv with data from implementation details
#   - loading csv lists students & their grades

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