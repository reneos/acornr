class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    # can view a booking if you are the host or the renter
    record.space.user == user || record.user == user
  end

  def create?
    # Can only create if the space does not belong to current user
    record.space.user != user
  end

  def update?
    record.space.user == user
  end
end

