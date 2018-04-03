require_relative "../config/environment.rb"
attr_accessor :name, :grade, :id

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
def inititialize(name, grade, id=nil)
  @name = name
  @grade = grade
  @id = id
end

def self.create_table
  sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students(
  id PRIMARY KEY INTEGER,
  name TEXT,
  grade INTEGER)
  SQL
end

end
