class ContestGroupPolicy < ApplicationPolicy
  def admin?
    user && user.admin?
  end

  actions = [:index?, :show?, :new?, :create?, :edit?, :update?, :destroy?]
  actions.each { |action| alias_method action, :admin?   }
end
