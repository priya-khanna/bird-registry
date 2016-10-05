require 'rails_helper'

RSpec.describe BirdsController, type: :controller do
  include ActiveJob::TestHelper

  describe "POST #create" do
    context "with valid data" do
      it "creates new bird entry" do
        post :create, { name: "Test bird", family: "Test family", added: Time.now.strftime("%Y-%m-%d"), continents: ['abc', 'def'] , visible: true }
        expect(response).to have_http_status('201')
      end
    end

    context "with invalid data" do
      it "fails with errors" do
        post :create, { name: "Test bird 1", family: "Test family", continents: "abc" }
        expect(response).to have_http_status('400')
        expect(JSON.parse(response.body)).to eq({"error"=>"Failed due to errors: Continents should be array of unique string values"})
      end
    end
  end

  describe "GET #index" do
    context "when birds do not exist" do
      it "shows blank response" do
        get :index
        expect(response).to have_http_status('200')
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context "when birds exist" do
      let!(:bird1) { FactoryGirl.create(:bird, name: 'test1', visible: true) }
      let!(:bird2) { FactoryGirl.create(:bird, name: 'test2', visible: false) }
      it "results in only visible ones" do
        get :index
        expect(response).to have_http_status('200')
        expect(JSON.parse(response.body).count).to eq(1)
      end
    end
  end

  describe "DELETE #delete" do
    context "when bird not found" do
      let!(:bird) { FactoryGirl.create(:bird, visible: true) }
      it "errors out" do
        delete :delete, { id: 1234 }
        expect(response).to have_http_status('404')
        expect(JSON.parse(response.body)).to eq({"error"=>"Not found"})
      end
    end

    context "when bird is found" do
      let(:bird) { FactoryGirl.create(:bird) }
      it "deletes it" do
        delete :delete, { id: bird.id }
        expect(response).to have_http_status('200')
        expect(JSON.parse(response.body)).to eq({"success"=>"Successfully deleted!"})
      end
    end
  end

end
