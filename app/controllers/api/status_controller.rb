class Api::StatusController < ApplicationController
  def check
    render json: { alive: true }
  end
end
