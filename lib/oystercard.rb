require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :history, :journey_klass
  attr_accessor :balance, :journey

  MINIMUM_FARE = 1
  MAXIMUM_FARE = 6
  DEFAULT_BALANCE = 0
  LIMIT = 90

  def initialize (balance = DEFAULT_BALANCE, journey_klass = Journey)
    @balance = balance
    @journey_klass = journey_klass
    @history = []
  end

  def top_up(value)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if balance + value > LIMIT
    @balance += value
  end

  def touch_in(station)
    fail "Unable to touch in: insufficient balance" if balance < MINIMUM_FARE
    if journey
      if !journey.complete?
        self.deduct(MAXIMUM_FARE)
      else
        @journey = journey_klass.new(station)
      end
    else
        @journey = journey_klass.new(station)
    end
  end

  def touch_out(station)
    if !journey.complete?
      journey.exit_station(station)
      deduct(journey.fare)
      history << journey
    else
      @journey = journey_klass.new(station)
      journey.entry_station = nil
      journey.exit_station(station)
      deduct(penalty)
      history << journey
    end
  end

  # def in_journey?
  #   journey.complete?
  # end


  def deduct(num)
    @balance -= num
  end

  def penalty
    MAXIMUM_FARE
  end

end
