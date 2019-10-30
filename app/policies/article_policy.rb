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

  def new?
    @user.journalist?
  end

  def create?
    new?
  end  

  def edit?
    @user.journalist?
  end
end