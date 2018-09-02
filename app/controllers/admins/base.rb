class Admins::Base < ActionController::Base
  before_action :authenticate_admin!
  layout 'admin'
end