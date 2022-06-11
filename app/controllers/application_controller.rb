class ApplicationController < ActionController::Base
  def hello
    render html: 'Hello World'
  end

  def current_user
    User.first
  end

  def self.current_user
    User.first
  end
end
