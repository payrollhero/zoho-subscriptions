require "spec_helper"

describe Zoho::Subscriptions::Plan do
  let(:product_id) { 187955000000050119 }
  subject(:plan) { described_class.find id }

  describe ".all" do
    context "unfiltered" do
      let(:all_plans) { described_class.all }

      example {
        expect(all_plans.count).to eq 2
        expect(all_plans.first).to be_a Zoho::Subscriptions::Plan
        expect(all_plans.last).to be_a Zoho::Subscriptions::Plan
      }
    end

    context "filtered" do
      let(:all_plans) { described_class.all product_id: product_id }

      example { expect(all_plans.count).to eq 1 }
    end
  end

  describe ".find" do
    context "when the plan exists" do
      let(:id) { "100-ammunition-per-month" }
      let(:expected_plan) { described_class.new id: "100-ammunition-per-month" }

      it { expect(described_class.find id).to eq expected_plan }
    end

    context "when the plan could not be found" do
      let(:id) { 0 }

      it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
    end
  end

  describe ".create" do
    let(:new_plan_details) {
      {
        plan_code: "100-ammunition-per-month",
        name: "Ammunition Galore",
        recurring_price: 99_999.99,
        interval: 1,
        product_id: product_id
      }
    }

    it { expect(described_class.create new_plan_details).to be_a Zoho::Subscriptions::Plan }
  end

  describe "#update" do
    let(:id) { "100-ammunition" }
    let(:plan) { described_class.find id }

    it {
      expect { plan.update name: "Ammunition Bonanza" }.to(
        change(plan, :name).from("Ammunition Galore").to("Ammunition Bonanza")
      )
    }
  end

  describe "#destroy" do
    let(:id) { "100-ammunition-per-month" }
    let(:plan) { described_class.find id }

    before { plan.destroy }

    it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
  end
end
