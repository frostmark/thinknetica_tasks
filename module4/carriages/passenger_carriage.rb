# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_reader :seats

  SEATS_MIN_MAX = 10..80

  def initialize(seats: 20)
    @seats = seats
    super(type: 'passenger')
    @reserved_seats = []
  end

  def reserve_seat(number)
    seat_exist? number
    seat_available? number

    @reserved_seats << number
  end

  def free_seats
    @seats - @reserved_seats.size
  end

  def reserved_seats
    @reserved_seats.count
  end

  protected

  def validate!
    super
    msg = "Number of seats must be\
          from #{SEATS_MIN_MAX.first}\
          to #{SEATS_MIN_MAX.last}"
    raise ArgumentError, msg unless SEATS_MIN_MAX.include? @seats
  end

  def seat_exist?(number)
    msg = "Seat with number #{number} not exist!"
    raise ArgumentError, msg unless (1..@seats).cover? number
  end

  def seat_available?(number)
    msg = 'Seat already was reserverd!'
    raise msg if @reserved_seats.include? number
  end
end
