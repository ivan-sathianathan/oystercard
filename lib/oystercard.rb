require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :history, :journey, :journey_klass

  MINIMUM_FARE = 1
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
    # touch_out(nil) if in_journey?
    fail "Unable to touch in: insufficient balance" if balance < MINIMUM_FARE
    if journey
      touch_out(nil)
    else
    @journey = journey_klass.new
    journey.entry_station(station)
    end
  end

  def touch_out(station)
    if journey
      journey.exit_station(station)
      deduct(journey.fare)
      history << journey
    else
      @journey = journey_klass.new
      journey.entry_station(nil)
      journey.exit_station(station)
      deduct(journey.fare)
      history << journey
    end
  end

  def in_journey?
    journey.complete?
  end

private
  def deduct(num)
    @balance -= num
  end
end


