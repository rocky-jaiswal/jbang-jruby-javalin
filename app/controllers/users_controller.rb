require './app/models/user'

class UsersController

  def find_all
    User.new.find_all
  end

end
