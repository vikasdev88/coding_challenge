require 'spec_helper'

describe CookiesController do
  let(:user) { create(:user) }
  let(:oven) { user.ovens.first }

  describe 'GET new' do
    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        get "/ovens/#{oven.id}/cookies/new"
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        get "/ovens/#{oven.id}/cookies/new"
        expect(response).to_not be_a_redirect
      end

      context "when a valid oven is supplied" do
        it "assigns @oven" do
          get "/ovens/#{oven.id}/cookies/new"

          expect(assigns(:oven)).to eq(oven)
        end
      end

      context "when an invalid oven is supplied" do
        it "is not successful" do
          expect {
            get "/ovens/#{create(:oven).id}/cookies/new"
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe 'POST create' do
    let(:quantity) { 1 }
    let(:cookie_params) do
      { fillings: 'Vanilla', quantity: quantity }
    end

    context "when not authenticated" do
      before { sign_in nil }

      it "blocks access" do
        post "/ovens/#{oven.id}/cookies", params: { cookie: cookie_params }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        expect {
          post "/ovens/#{oven.id}/cookies", params: { cookie: cookie_params }
        }.to_not raise_error
      end

      context "when a valid oven is supplied" do
        context "when valid quantity is supplied" do
          it "creates a cookie for that oven" do
            expect {
              post "/ovens/#{oven.id}/cookies", params: { cookie: cookie_params }
            }.to change{Cookie.count}.by(1)

            expect(Cookie.last.storage).to eq(oven)
          end

          it "redirects to the oven" do
            post "/ovens/#{oven.id}/cookies", params: { cookie: cookie_params }
            expect(response).to redirect_to oven_path(oven)
          end

          it "assigns valid cookie parameters" do
            post "/ovens/#{oven.id}/cookies", params: { cookie: cookie_params }
            expect(Cookie.last.fillings).to eq(cookie_params[:fillings])
          end
        end

        context "when invalid quantity is supplied" do
          let(:quantity) { nil }

          before { post "/ovens/#{oven.id}/cookies", params: { cookie: cookie_params } }

          it "is not successful" do
            expect(flash.now[:alert]).to eq('Enter valid quantity')
            expect(response).to render_template(:new)
          end
        end
      end

      context "when an invalid oven is supplied" do
        it "is not successful" do
          expect {
            post "/ovens/#{create(:oven).id}/cookies", params: { cookie: cookie_params }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

  end
end
