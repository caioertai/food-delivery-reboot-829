require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # Ask VIEW to ask user for username
    username = @sessions_view.ask_for("username")
    # Ask VIEW to ask user for password
    password = @sessions_view.ask_for("password")
    # Ask REPO(employee) for the user of the given username
    employee = @employee_repository.find_by_username(username)
    # Ask USER if the password matches
    if !employee.nil? && employee.password_match?(password)
      ## Ask VIEW to display a greeting
      @sessions_view.greet(employee)
      return employee
    else
      ## Ask VIEW to display an error
      @sessions_view.login_error
      return nil
    end
  end
end
