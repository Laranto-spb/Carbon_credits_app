# spec/services/carbon_registry/carbon_projects_query_spec.rb
require "rails_helper"

RSpec.describe CarbonRegistry::CarbonProjectsQuery do
  let(:country) { "Brazil" }
  let(:status)  { "active" }
  let(:page)    { 2 }
  let(:per_page) { 5 }
  let(:sort_by) { "total_credits_issued" }
  let(:sort_order) { "desc" }

  describe "#call" do
    context "when no filters are applied" do
      it "returns all projects with default pagination" do
        create_list(:carbon_project, 10)

        projects, total = described_class.new(page: 1, per_page: 5).call

        expect(projects.size).to eq(5)
        expect(total).to eq(10)
      end
    end

    context "with country filter" do
      it "filters projects by country" do
        create(:carbon_project, country: country)
        create(:carbon_project, country: "USA")

        projects, total = described_class.new(country: country, page: 1, per_page: 10).call

        expect(projects.map(&:country).uniq).to eq([ country ])
        expect(total).to eq(1)
      end
    end

    context "with status filter" do
      it "filters projects by status" do
        create(:carbon_project, status: status)
        create(:carbon_project, status: "pending")

        projects, total = described_class.new(status: status, page: 1, per_page: 10).call

        expect(projects.map(&:status).uniq).to eq([ status ])
        expect(total).to eq(1)
      end
    end

    context "sorting" do
      it "sorts by allowed columns only" do
        create(:carbon_project, total_credits_issued: 100)
        create(:carbon_project, total_credits_issued: 200)

        projects, _ = described_class.new(sort_by: "total_credits_issued", sort_order: "desc", page: 1, per_page: 10).call
        expect(projects.first.total_credits_issued).to eq(200)
      end

      it "ignores invalid sort_by and uses default order" do
        projects, _ = described_class.new(sort_by: "secret_column", page: 1, per_page: 10).call
        expect(projects).to be_an(Array)
      end
    end

    context "pagination" do
      it "applies offset and limit correctly" do
        create_list(:carbon_project, 7)

        projects1, total1 = described_class.new(page: 1, per_page: 5).call
        projects2, total2 = described_class.new(page: 2, per_page: 5).call

        expect(projects1.size).to eq(5)
        expect(projects2.size).to eq(2)
        expect(total1).to eq(7)
        expect(total2).to eq(7)
      end
    end

    context "caching" do
      it "uses Rails.cache with a consistent cache key" do
        allow(Rails.cache).to receive(:fetch).and_call_original

        described_class.new(
          country: country,
          status: status,
          page: page,
          per_page: per_page,
          sort_by: sort_by,
          sort_order: sort_order
        ).call

        expect(Rails.cache).to have_received(:fetch).with(
          a_string_including("carbon:projects:query"),
          hash_including(expires_in: 3.minutes)
        )
      end
    end
  end
end
