class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show ]

  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  def show
    render json: @reservation
  end

  def create
    payload = JSON.parse(request.body.read)
    processor = ReservationProcessor.new(payload)

    @reservation = processor.process
    render json: @reservation, status: :created, location: @reservation
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end