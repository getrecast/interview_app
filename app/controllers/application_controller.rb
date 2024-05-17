class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.first || User.create(channels: %w[date facebook radio	billboards])
  end
end
