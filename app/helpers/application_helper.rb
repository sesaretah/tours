module ApplicationHelper

  def transportations
    @options = [
      [t(:airline), 'Airline'],
      [t(:railway) , 'Railway'],
      [t(:bus) , 'Bus']
    ]
    return @options
  end
  def transportation_types
    @options = [
      [t(:departure), 'Departure'],
      [t(:arrival) , 'Arrival'],
      [t(:surfing) , 'Surfing']
    ]
    return @options
  end
end
