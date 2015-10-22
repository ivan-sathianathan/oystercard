class Journey

  MINIMUM_FARE = 1
  MAXIMUM_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end


  def touch_in(station)
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
  end

  def fare
    if complete?
      fare = MINIMUM_FARE
    else
      fare = MAXIMUM_FARE
    end
  end

  def complete?
    @entry_station != nil && @exit_station != nil ? true : false
  end

end
