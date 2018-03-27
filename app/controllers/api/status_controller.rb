class Api::StatusController < ApplicationController
  def alive
    render json: {alive: true}    
  end
end
