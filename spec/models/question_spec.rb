require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create(:user) }
  describe 'Create a Question' do
    it 'able to create a question' do
      question = user.questions.create('title':'test')
      expect(question.valid?). to eq true
      expect(Question.count). to eq 1
    end
  end
end
