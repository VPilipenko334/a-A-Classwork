

class Employee


  attr_reader :employee_name, :title, :salary, :boss

  def initialize(employee_name, title, salary, boss)
    @employee_name = employee_name
    @title = title
    @salary = salary
    @boss = boss
  end


end
