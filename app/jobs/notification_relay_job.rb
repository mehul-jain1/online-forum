class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification_type, notification_content, resource_id = nil)
    ActionCable.server.broadcast 'web_notifications_channel', notification_type: notification_type, html: notification_content, resource_id: resource_id
  end
end
