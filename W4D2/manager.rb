module Manager
  attr_reader :all_employees

  def manager_bonus(multiplier)
    bonus = 0

    all_employees.each do |employee|
      bonus += employee.salary
    end

    bonus * multiplier
  end

end
