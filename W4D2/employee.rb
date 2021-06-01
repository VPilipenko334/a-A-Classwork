require "manager.rb"

class Employee
  
  extend Manager

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
