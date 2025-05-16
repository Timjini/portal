require "rails_helper"

RSpec.describe KpiCategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/kpi_categories").to route_to("kpi_categories#index")
    end

    it "routes to #new" do
      expect(get: "/kpi_categories/new").to route_to("kpi_categories#new")
    end

    it "routes to #show" do
      expect(get: "/kpi_categories/1").to route_to("kpi_categories#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/kpi_categories/1/edit").to route_to("kpi_categories#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/kpi_categories").to route_to("kpi_categories#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/kpi_categories/1").to route_to("kpi_categories#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/kpi_categories/1").to route_to("kpi_categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/kpi_categories/1").to route_to("kpi_categories#destroy", id: "1")
    end
  end
end
