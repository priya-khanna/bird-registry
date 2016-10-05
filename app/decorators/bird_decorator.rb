require_dependency 'application_decorator'
class BirdDecorator < ApplicationDecorator

  def id
    model.id.to_s
  end

  protected
  def attributes_for_output
    %w(id name family continents added visible)
  end

end
