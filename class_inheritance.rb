class Employee
  attr_reader :name, :title, :salary, :boss
  def initialize(name, title, salary, boss=nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss=nil)
    @employees = []
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    total_bonus = 0
    employees.each do |employee|
      total_bonus += employee.salary
    end
    total_bonus * multiplier
  end

  def add_employee(*employee)
    employee.each do |person|
      employees << person
    end
  end
end

ned = Manager.new("ned", "founder", 1000000)
darren = Manager.new("darren", "ta manager", 78000, ned)
shawna = Employee.new("shawna", "ta", 12000, darren)
david = Employee.new("david", "ta", 10000, darren)

ned.add_employee(darren,shawna,david)
darren.add_employee(shawna,david)
p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
