require 'pry'
class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute('DROP TABLE students;')
  end

  def save
    DB[:conn].execute('INSERT INTO students (name, grade) VALUES (?, ?)',@name, @grade)
    @id = DB[:conn].execute('SELECT last_insert_rowid() FROM students')[0][0]
  end

  def self.create(student_hash)
    new_student = Student.new(student_hash.values[0], student_hash.values[1])
    new_student.save
    new_student
  end
end

# takes in a hash of attributes and uses metaprogramming to create a new student object.
# Then it uses the #save method to save that student to the database (FAILED - 1)
# returns the new object that it instantiated (FAILED - 2)

# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]
# drop_table
#   drops the students table from the database (FAILED - 1)
#  #save
#   saves an instance of the Student class to the database (FAILED - 2)
#  .create
# takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database (FAILED - 3)
# returns the new object that it instantiated (FAILED - 4)
