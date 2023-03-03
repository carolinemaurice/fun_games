class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    record.user == user
  end

  def decline?
    record.game.user == user
  end

  def accept?
    record.game.user == user
  end
end
