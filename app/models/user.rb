class User < ApplicationRecord
  scope :upcoming, -> { where("event_date > ?", Time.now.strftime("%Y-%m-%d") ).order(event_date: :asc) } 
  scope :past, -> { where("event_date < ?", Time.now.strftime("%Y-%m-%d") ).order(event_date: :desc) } 


  has_many :events, foreign_key: "creator_id"

  has_many :attendances, foreign_key: :attendee_id

  has_many :attended_events, through: :attendances, source: :attended_event

  def upcoming_events
    self.attended_events.upcoming
  end

  def previous_events
    self.attended_events.past
  end
end
