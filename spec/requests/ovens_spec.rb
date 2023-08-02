require 'spec_helper'

describe OvensController do
  let(:user) { create(:user) }

  describe 'GET index' do
    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        get '/ovens'
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        get '/ovens'
        expect(response).to_not be_a_redirect
      end

      it "assigns the user's ovens" do
        get '/ovens'

        expect(assigns(:ovens)).to eq(user.ovens)
      end
    end
  end

  describe 'GET show' do
    let(:oven) { create(:oven, user: user) }

    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        get "/ovens/#{oven.id}"
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        get "/ovens/#{oven.id}"
        expect(response).to_not be_a_redirect
      end

      it "assigns the @oven" do
        get "/ovens/#{oven.id}"
        expect(assigns(:oven)).to eq(oven)
      end

      context "when requesting someone else's oven" do
        let(:oven) { create(:oven) }

        it "blocks access" do
          expect {
            get "/ovens/#{oven.id}"
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe 'POST empty' do
    let(:oven) { create(:oven, user: user) }

    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        post "/ovens/#{oven.id}/empty"
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        expect {
          post "/ovens/#{oven.id}/empty"
        }.to_not raise_error
      end

      it "assigns the @oven" do
        post "/ovens/#{oven.id}/empty"
        expect(assigns(:oven)).to eq(oven)
      end

      it "moves the oven's cookie to the user" do
        cookie = create(:cookie, storage: oven, status: 'ready')

        post "/ovens/#{oven.id}/empty"

        expect(oven.cookies).to be_empty
        expect(user.stored_cookies.to_a).to match_array([cookie])
      end

      context "when requesting someone else's oven" do
        let(:oven) { create(:oven) }

        it "blocks access" do
          expect {
            post "/ovens/#{oven.id}/empty"
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

  end
end
