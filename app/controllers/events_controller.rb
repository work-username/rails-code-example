class EventsController < ApplicationController
  def index
    render json: Event.starts_before(params[:end]).ends_after(params[:start])
  end

  def create
    record = Event.new(event_params)
    status = record.save ? :ok : :unprocessable_entity

    render json: record, errors: record.errors.messages, status: status
  end

  private

  def event_params
    params.require(:event).permit(:title, :starts_at, :ends_at)
  end
end
