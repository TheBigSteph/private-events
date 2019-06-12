class EventsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :index, :destroy]

    def new
        @event = Event.new
    end

    def index
      @events = Event.order("created_at")
      @upcoming = Event.upcoming
      @past_events = Event.past
    end

    def show
      @event = Event.find_by(id: params[:id])
      @creator_event = @event.creator
      @attendances = @event.attendees
      @invitation =  Attendance.new
      @not_invited = Event.not_invited(@event.attendees).map { |u| [ u.name, u.id ] }
      @count_invited = Event.not_invited(@event.attendees).count
    end

    def create
        @event = current_user.events.build(events_params)
        if @event.save
            Attendance.create(attendee_id: current_user.id, attended_event_id: @event.id)
            flash[:alert] = "Created event"
            redirect_to @event
        else
            render :new
        end
    end

    def destroy 
        @event = Event.find(params[:id])
        if @event.destroy
          flash[:alert] = "Event Deleted"
          redirect_to root_path 
        else
          redirect_to @event
        end
      end


    private

    def events_params
        params.require(:event).permit(:title, :content, :location, :event_date)
    end

    def logged_in_user
        unless logged_in?
          flash[:danger] = "Please Log in"
          redirect_to login_url
        end
    end

end
