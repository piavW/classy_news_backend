class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      Scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.journalist?
  end

  def edit?
    @user.journalist?
  end
end