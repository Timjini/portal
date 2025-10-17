# spec/routing/admin/competitions_routing_spec.rb
require "rails_helper"

RSpec.describe Admin::CompetitionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/competitions").to route_to(
        controller: "admin/competitions",
        action: "index"
      )
    end

    it "routes to #show" do
      expect(get: "/admin/competitions/1").to route_to(
        controller: "admin/competitions",
        action: "show",
        id: "1"
      )
    end

    it "routes to #new" do
      expect(get: "/admin/competitions/new").to route_to(
        controller: "admin/competitions",
        action: "new"
      )
    end

    it "routes to #edit" do
      expect(get: "/admin/competitions/1/edit").to route_to(
        controller: "admin/competitions",
        action: "edit",
        id: "1"
      )
    end

    it "routes to #create" do
      expect(post: "/admin/competitions").to route_to(
        controller: "admin/competitions",
        action: "create"
      )
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/competitions/1").to route_to(
        controller: "admin/competitions",
        action: "update",
        id: "1"
      )
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/competitions/1").to route_to(
        controller: "admin/competitions",
        action: "update",
        id: "1"
      )
    end

    it "routes to #destroy" do
      expect(delete: "/admin/competitions/1").to route_to(
        controller: "admin/competitions",
        action: "destroy",
        id: "1"
      )
    end
  end
end
