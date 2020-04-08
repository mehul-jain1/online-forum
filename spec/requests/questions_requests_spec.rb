require 'rails_helper'


describe QuestionsController, :type => :request do

  let(:user) { create(:user) }

  describe 'Authentication' do
    context 'without login' do
      it 'should deny access to questions#new' do
        get new_question_path
        expect_sign_in
      end
      it 'should deny access to questions#create' do
        post questions_path
        expect_sign_in
      end
    end
  end

  describe 'Authorization' do
    context 'valid access' do
      it 'loads the questions' do
        get questions_path
        expect_success
      end
    end
  end
end
