class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def menu
  end

  def ranks
    @ranks = User.order(points: :desc)
  end
end
