require_relative "manager.rb"

class Employee 
  
  include Manager 

  attr_reader :employee_name, :title, :salary, :boss

  def initialize(employee_name, title, salary, boss)
    @employee_name = employee_name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = (salary) * multiplier
  end

end

p Sam = Employee.new("Sam", "worker", "100", "Veronika")
p Sam.manager_bonus(2)
