require 'java'

java_import 'org.jdbi.v3.core.Jdbi'

class User

  attr_reader :jdbi

  def initialize
    @jdbi = Jdbi.create("jdbc:sqlite:db.sqlite")
  end

  def find_all
    users = []
    jdbi.useHandle do |handle|
      users = handle.createQuery("SELECT * FROM users").mapToMap.list()
    end
    users
  end

end
