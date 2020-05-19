class DashboardController < ApplicationController
  def index
    @dashboard = Dashboard.add
  end
end
