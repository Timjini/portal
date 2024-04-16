class ApiBaseController < ActionController::Base
   require 'json_web_token'
   before_action :authenticate_user!
    
end