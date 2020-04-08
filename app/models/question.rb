class Question < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  validates :title, presence: true
  after_commit :add_notification, on: :create
  
  private

  def add_notification
  	Notification.create(name: "#{self.title} #{self.description}")	
  end
end
