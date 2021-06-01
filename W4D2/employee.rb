require_relative "manager.rb"

class Employee
  include Manager

  attr_reader :employee_name, :title, :salary, :boss

  def initialize(employee_name, title, salary, boss)
    @employee_name = employee_name
    @title = title
    @salary = salary
    @boss = boss
    @all_employees = []
  end

  def bonus(multiplier)
    bonus = (salary) * multiplier
  end
end

Sam = Employee.new("Sam", "worker", 100, "Veronika")
Alvin = Employee.new("Alvin", "worker", 100, "Veronika")
Veronika = Employee.new("Veronika", "worker", 100, "Veronika")
Bill = Employee.new("Bill", "worker", 100, "Veronika")
Jessie = Employee.new("Jessie", "worker", 100, "Veronika")

Sam.all_employees << Alvin
Sam.all_employees << Veronika
Sam.all_employees << Bill
Sam.all_employees << Jessie

p Sam.manager_bonus(2)
