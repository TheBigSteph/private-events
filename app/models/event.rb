class Event < ApplicationRecord
    belongs_to :creator, class_name: "User"

    has_many :attendances, foreign_key: :attended_event_id

    has_many :attendees, through: :attendances

    def self.not_invited(attendees)
        User.where.not(id: attendees)
    end
    
    def upcoming
        self.attended_events.where("event_date > ?", Time.now.strftime("%Y-%m-%d") ).order(event_date: :asc)
      end
    
      def past
        self.attended_events.where("event_date < ?", Time.now.strftime("%Y-%m-%d") ).order(event_date: :desc)
      end

end
