class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def current_user
  #   super || guest_user
  # end

  # private

  # def guest_user
  #  User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  # end

  # def create_guest_user
  #   user = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(99)}@example.com")
  #   user.save(:validate => false)
  #   user
  # end
end
