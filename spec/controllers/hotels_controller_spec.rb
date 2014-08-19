require 'spec_helper'

describe HotelsController do
  before (:each) do
    @user = create(:user)
    sign_in @user
  end

  let!(:hotel) { create(:hotel) }

  describe 'index,' do
    it 'returns http success' do
      sign_in :user, @user
      get :index
      expect(response).to be_success
    end
  end

  describe 'show,' do
    it 'returns http success' do
      sign_in :user, @user
      get :show, id: hotel.id
      expect(response).to be_success
    end
  end

  describe 'new,' do
    it 'returns http success' do
      sign_in :user, @user
      get :new
      expect(response).to be_success
    end
  end

  describe 'create,' do
    it 'creates hotel' do
      sign_in :user, @user
      expect{post :create, { hotel: {title: 'h1', rating: 5} }}.to change(Hotel, :count).by(1) and
          expect(response).to redirect_to hotel_path(Hotel.find 2)
    end
  end

  describe 'destroy,' do
    it 'destroys hotel' do
      sign_in :user, @user
      expect{delete :destroy, id: hotel.id}.to change(Hotel, :count).by(-1) and
          expect(response).to redirect_to hotels_path
    end
  end

  describe 'create_comment,' do
    it 'creates comment' do
      sign_in :user, @user
      expect{post :create_comment, { format: hotel.id, comment: {body: 'c1', rating: 5} }}.
          to change(Comment, :count).by(1) and
          expect(response).to redirect_to hotel_path(hotel)
    end
  end
end