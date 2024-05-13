class HomeController < ApplicationController
  def index
    @buffets = Buffet.where(active: true)
  end
end