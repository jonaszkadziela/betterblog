module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_current_user
    end

    protected

    def find_current_user
      User.find_by(id: cookies.signed["user.id"])
    end
  end
end
