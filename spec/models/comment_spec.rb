require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:comment) { create(:comment, commentable: question, user: user) }

  describe 'Create a Comment' do
    it 'able to create a comment on a question' do
      comment = question.comments.create('body':'test', user:user)
      expect(comment.valid?). to eq true
      expect(Comment.count). to eq 1
    end
  end

  describe 'Reply to Comment' do
    it 'able to reply to a comment on a question' do
      reply = comment.comments.create('body':'test', user: user)
      expect(reply.valid?). to eq true
      expect(Comment.count). to eq 2
    end
  end
end
