class User < ApplicationRecord
  has_many :events, foreign_key: "creator_id"

  has_many :attendances, foreign_key: :attendee_id

  has_many :attended_events, through: :attendances

  def upcoming_events
    self.attended_events.where("event_date > ?", Time.now.strftime("%Y-%m-%d") ).order(event_date: :asc)
  end

  def previous_events
    self.attended_events.where("event_date < ?", Time.now.strftime("%Y-%m-%d") ).order(event_date: :desc)
  end
end
