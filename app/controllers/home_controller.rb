class HomeController < ApplicationController
  def hello
  	@time = Date.today
  end
  def goodbye
  	@tomorrow = Date.today + 1.day
  end
end
