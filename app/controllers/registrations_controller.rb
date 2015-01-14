class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!
  clear_respond_to
  respond_to :json
end