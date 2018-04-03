require_relative "../config/environment.rb"


class Student
attr_accessor :name, :grade
attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
def inititialize(id=nil, name, grade)
  @name = name
  @grade = grade
  @id = id
end

def self.create_table
  sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students(
  id INTEGER PRIMARY KEY ,
  name TEXT,
  grade INTEGER)
  SQL

  DB[:conn].execute(sql)
end

def self.drop_table
  sql = <<-SQL
  DROP TABLE IF EXISTS students
  SQL

  DB[:conn].execute(sql)
end

def save
  if self.id
    self.update
  else
  sql = <<-SQL
  INSERT INTO students (name, grade) VALUES (?, ?)
  SQL

  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
end

def update
  sql = "UPDATE students SET name = ?, grade = ?, WHERE id = ?"
  DB[:conn].execute(sql, self.name, self.grade, self.id)
end

def self.create
  beyonce = Self.new(name, grade)
  beyonce.save
  beyonce
end

def self.new_from_db
  Self.new(row[0], row[1], row[2])
end

end
