require "rails_helper"

RSpec.describe TheatersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/theaters").to route_to("theaters#index")
    end

    it "routes to #new" do
      expect(get: "/theaters/new").to route_to("theaters#new")
    end

    it "routes to #show" do
      expect(get: "/theaters/1").to route_to("theaters#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/theaters/1/edit").to route_to("theaters#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/theaters").to route_to("theaters#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/theaters/1").to route_to("theaters#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/theaters/1").to route_to("theaters#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/theaters/1").to route_to("theaters#destroy", id: "1")
    end
  end
end
