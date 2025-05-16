class Coaches::AssessmentsController < ApplicationController
  
  def index
    puts "--------------->#{session[:step].inspect}"
  end
end