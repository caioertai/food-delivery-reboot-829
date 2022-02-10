require "csv"
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @employees = []

    load_csv if File.exist?(@csv_path)
  end

  def all
    @employees
  end

  def riders
    all.select { |employee| employee.rider? }
  end

  def create(employee)
    employee.id = next_id
    @employees << employee

    update_csv
  end

  def find(id)
    @employees.find { |employee| employee.id == id } # employee instance
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username } # employee instance
  end

  private

  def next_id
    @employees.empty? ? 1 : @employees.last.id + 1
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id username password role]
      @employees.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end


  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      # Type casting
      row[:id] = row[:id].to_i

      @employees << Employee.new(
        id: row[:id],
        username: row[:username],
        password: row[:password],
        role: row[:role]
      )
    end
  end
end
