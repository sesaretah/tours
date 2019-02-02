module ApplicationHelper

  def transportations
    @options = [
      ["",""],
      [t(:airlines), 'airlines'],
      [t(:railways) , 'railways'],
      [t(:buses) , 'buses']
    ]
    return @options
  end
  def transportation_types
    @options = [
      ["",""],
      [t(:departure), 'Departure'],
      [t(:arrival) , 'Arrival'],
      [t(:surfing) , 'Surfing']
    ]
    return @options
  end

  def railway_types
    @options = [
      [t(:coupe_type), 'coupe_type'],
      [t(:bus_type) , 'bus_type']
    ]
    return @options
  end

  def grant_access(ward, user)
    @flag = 0
    if Role.all.blank? #when new app starts
      return true
    end
    if user.assignments.blank?
      return false
    end

    if user.current_role_id.blank?
      return false
    else
      @ac = AccessControl.where(role_id: user.current_role_id).first
      @flag = @ac["#{ward}"] && 1 || 0
    end

    if @flag == 0
      return false
    else
      return true
    end
  end
end
