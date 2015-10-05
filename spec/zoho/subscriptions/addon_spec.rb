require "spec_helper"

describe Zoho::Subscriptions::Addon do
  let(:product_id) { 187955000000050119 }
  subject(:addon) { described_class.find id }

  describe ".all" do
    let(:all_addons) { described_class.all }

    example {
      expect(all_addons.count).to eq 2
      expect(all_addons.first).to be_a Zoho::Subscriptions::Addon
      expect(all_addons.last).to be_a Zoho::Subscriptions::Addon
    }
  end

  describe ".find" do
    context "when the addon exists" do
      let(:id) { "target" }
      let(:expected_addon) { described_class.new id: "target" }

      it { expect(described_class.find id).to eq expected_addon }
    end

    context "when the addon could not be found" do
      let(:id) { 0 }

      it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
    end
  end

  describe ".create" do
    let(:new_addon_details) {
      {
        addon_code: "bulls-eye",
        name: "Bull's Eye",
        unit_name: "piece",
        price_brackets: [
          {
            price: 9.99
          }
        ],
        applicable_to_all_plans: true,
        product_id: product_id
      }
    }

    it { expect(described_class.create new_addon_details).to be_a Zoho::Subscriptions::Addon }
  end

  describe "#update" do
    let(:id) { "target" }
    let(:addon) { described_class.find id }

    it {
      expect { addon.update name: "Red Dot" }.to(
        change(addon, :name).from("Target").to("Red Dot")
      )
    }
  end

  describe "#destroy" do
    let(:id) { "target" }
    let(:addon) { described_class.find id }

    before { addon.destroy }

    it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
  end
end
