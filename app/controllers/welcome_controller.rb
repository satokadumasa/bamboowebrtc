class WelcomeController < ApplicationController
  def index
    @rooms = Room.all.order(:id)
  end
end
