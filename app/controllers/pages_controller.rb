class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @spaces = policy_scope(Space).sample(6)
  end
end
