class Notification < ApplicationRecord
  # after_commit :send_notification, on: :create
  
  private

  def send_notification
    NotificationRelayJob.perform_later(self)
  end
end
