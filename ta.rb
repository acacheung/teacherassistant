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
    @students_array = []
    @class_average_array = []
    @all_grades = []
    show_analytics
  end

  def proper_name
    @student_name = @student_name.split.reverse.join(', ')
  end

  def find_average
    @sum = 0.0
    @average_array.each { |x| @sum = @sum + x }
    @student_average = @sum / @average_array.length
  end

  def assign_grade
    case @student_average
    when 0..59
      @student_grade = 'F'
    when 60..69
      @student_grade = 'D'
    when 70..79
      @student_grade = 'C'
    when 80..89
      @student_grade = 'B'
    when 90..100
      @student_grade = 'A'
    end
  end

  def show_analytics
    File.foreach('example.txt') do |l|
      CSV.parse(l)

      @average_array = l.chomp.split(',')
      @student_name = @average_array.shift
      @average_array.map! { |i| i.to_i }
      @all_grades.push(@average_array)

      proper_name
      find_average
      assign_grade
      class_average

      @report_style = "#{@student_name} #{@student_average} #{@student_grade}"
      @students_array.push([@report_style])
    end
    # report_card
    aggregate_info
  end

  def report_card
    File.open('report.txt', 'a') do |f|
      @students_array = @students_array.sort
      for i in 0..(@students_array.length - 1)
        f. puts @students_array[i][0]
      end
    end
  end

  def class_average
    sum = 0.0
    @class_average_array.push(@student_average)
    @class_average_array.each { |x| sum = sum + x }
    @class_average = sum / @class_average_array.length
  end

  # def standard_deviation
  #   return Math.sqrt(self.sample_variance)
  # end

  def min_max
    find_extremes = []
    for i in 0..(@all_grades.length - 1)
      @all_grades[i].each { |x| find_extremes.push(x) }
    end
    @min = find_extremes.min
    @max = find_extremes.max
  end

  def aggregate_info
    puts "The average score is #{@class_average}"
    min_max
    puts "The min score is #{@min}"
    puts "The max score is #{@max}"
    # standard_deviation
    # puts "The standard deviation is #{@class_average_array.standard_deviation}"
  end
end

# report = StudentReport.new
analytics = StudentReportAnalytics.new

# GIT "REPORT OUT AGGREGATE INFO"
# output course analytics
#   - output average score, min score, max score and standard deviation across the class












