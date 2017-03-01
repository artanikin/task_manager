require "rails_helper"

RSpec.describe Web::UsersController, type: :controller do
  describe "GET #new" do
    before { get :new }

    it "assigns new User to @user" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders view new" do
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:parameters) { { user: attributes_for(:user) } }

    subject { post :create, params: parameters }

    it "create new user in db" do
      expect{ subject }.to change(User, :count).by(1)
    end

    it "redirect to root" do
      subject
      expect(response).to redirect_to root_path
    end

    context "with invalid attributes" do
      let(:parameters) { { user: attributes_for(:invalid_user) } }

      it "does not save user" do
        expect{ subject }.to_not change(User, :count)
      end

      it "re-render view sign up form" do
        subject
        expect(response).to render_template(:new)
      end
    end
  end
end
