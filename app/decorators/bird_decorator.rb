require_dependency 'application_decorator'
class BirdDecorator < ApplicationDecorator

  protected
  def attributes_for_output
    %w(name family continents added visible)
  end

end
