class Journey

  MINIMUM_FARE = 1
  # MAXIMUM_FARE = 6
  attr_accessor :entry_station, :exit_station, :complete

  def initialize
    @history = []
    @complete = true
  end

  def entry_station(station)
    # @entry_station ? complete = false : true
    complete = false
    self.entry_station = station
  end

  def exit_station(station)
    self.exit_station = station
    complete = true
  end

  def fare
    # return MAXIMUM_FARE if @exit_station.nil? && complete?
    # return MAXIMUM_FARE if @entry_station.nil? && complete?
    MINIMUM_FARE
  end

  def complete?
    complete
  end

end
