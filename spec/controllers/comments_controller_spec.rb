require 'spec_helper'

describe CommentsController do
  before (:each) do
    @user = create(:user)
    sign_in @user
  end

  let!(:hotel) { create(:hotel) }


  describe 'create_comment,' do
    it 'creates comment' do
      sign_in :user, @user
      expect{post :create, { hotel_id: hotel.id, comment: {body: 'c1', rating: 5} }}.
          to change(Comment, :count).by(1) and
          expect(response).to redirect_to hotel_path(hotel)
    end
  end
end