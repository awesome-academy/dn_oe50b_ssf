require "rails_helper"
require "byebug"
RSpec.describe "Admin::SoccerFields", type: :request do
  let!(:soccer_field){FactoryBot.create(:soccer_field)}
  let!(:soccer_fields){FactoryBot.create_list(:soccer_field,2)}
  let(:valid_params){FactoryBot.create(:soccer_field).serializable_hash}
  let(:invalid_params){{field_name: ""}}
  let(:admin){FactoryBot.create(:admin)}
  let(:user){create(:user, :with_account_activated)}

  #1 - INDEX RSPEC
  describe "GET #index" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    before {get "/admin/soccer_fields"}

    it "assign @soccer_fields" do
      expect(assigns(:soccer_fields)).to be_truthy
    end

    it "renders the #index view" do
      expect(response).to render_template :index
    end

    it "returns a http status 200" do
      expect(response).to have_http_status(200)
    end
  end

  #2 - NEW RSPEC
  describe "GET #new" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    before {get "/admin/soccer_fields/new"}

    it "assigns a new @soccer_field" do
      expect(assigns(:soccer_field)).to be_a_new(SoccerField)
    end

    it "renders the #new view" do
      expect(response).to render_template :new
    end

    it "returns a http status 200" do
      expect(response).to have_http_status(200)
    end
  end

  #3 - EDIT RSPEC
  describe "GET #edit" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    context "found @soccer_field" do
      before {get "/admin/soccer_fields/#{soccer_field.id}/edit", params:{id: soccer_field.id}}

      it "assign @soccer_field" do
        expect(assigns(:soccer_field)).to eq(soccer_field)
      end

      it "renders the #edit view" do
        expect(response).to render_template :edit
      end

      it "returns a http status 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "not found @soccer_field" do
      before {get "/admin/soccer_fields/1000/edit", params:{id: 1000}}

      it "flash warning message" do
        expect(flash[:warning]).to eq I18n.t "soccer_fields_controller.load_fail"
      end

      it "redirect the #index view" do
        expect(response).to redirect_to :admin_soccer_fields
      end
    end
  end

  #4 - CREATE RSPEC
  describe "POST #create" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    context "create soccer_field success" do
      before do
        post "/admin/soccer_fields",
        params: {soccer_field: valid_params}
      end

      it "create a new soccer_field" do
        expect(assigns(:soccer_field)).to be_a SoccerField
      end

      it "flash success message" do
        expect(flash[:success]).to eq I18n.t "soccer_fields_controller.create_success"
      end
      # it{should expect(request).to set_flash[:success].to(I18n.t("soccer_fields_controller.create_success"))}

      it "redirects to the #index" do
        expect(response).to redirect_to :admin_soccer_fields
      end

    end

    context "create soccer_field fail" do
      before do
        post "/admin/soccer_fields",
        params: {soccer_field: invalid_params}
      end

      it "flash warning message" do
        expect(flash[:warning]).to eq I18n.t "soccer_fields_controller.create_warning"
      end

      it "re-renders the new view" do
        expect(response).to render_template :new
      end
    end
  end

  #5 - UPDATE RSPEC
  describe "PATCH #update" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    context "update soccer_field success" do
      before do
        patch "/admin/soccer_fields/#{soccer_field.id}",
        params: {soccer_field: valid_params,id: soccer_field.id}
      end

      it "update a soccer_field" do
        expect(assigns(:soccer_field)).to be_a SoccerField
      end

      it "flash success message" do
        expect(flash[:success]).to eq I18n.t "soccer_fields_controller.update_success"
      end

      it "redirects to the #index" do
        expect(response).to redirect_to :admin_soccer_fields
      end
    end

    context "update soccer_field fail" do
      before do
        patch "/admin/soccer_fields/#{soccer_field.id}",
        params: {soccer_field: invalid_params,id: soccer_field.id}
      end

      it "flash warning message" do
        expect(flash[:warning]).to eq I18n.t "soccer_fields_controller.update_warning"
      end

      it "re-renders the new view" do
        expect(response).to render_template :edit
      end
    end
  end

    #5 - DELETE RSPEC
  describe "DELETE #destroy" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end
    context "delete soccer_field success" do
      before do
        delete "/admin/soccer_fields/#{soccer_field.id}",
        params: {soccer_field: valid_params,id: soccer_field.id}
      end

      it "flash success message" do
        expect(flash[:success]).to eq I18n.t "soccer_fields_controller.destroy_success"
      end

      it "redirects to the #index" do
        expect(response).to redirect_to :admin_soccer_fields
      end
    end

    context "delete soccer_field fail" do
      before do
        delete "/admin/soccer_fields/#{soccer_field.id}",
        params: {soccer_field: invalid_params,id: soccer_field.id}
      end

      it "redirects to the #index" do
        expect(response).to redirect_to :admin_soccer_fields
      end
    end
  end
end
