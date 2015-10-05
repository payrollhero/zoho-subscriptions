require "spec_helper"

describe Zoho::Subscriptions::Product do
  subject(:product) { described_class.find id }

  describe ".all" do
    let(:all_products) { described_class.all }

    example {
      expect(all_products.count).to eq 2
      expect(all_products.first).to be_a Zoho::Subscriptions::Product
      expect(all_products.last).to be_a Zoho::Subscriptions::Product
    }
  end

  describe ".find" do
    context "when the product exists" do
      let(:id) { 187955000000050117 }
      let(:expected_product) { described_class.new id: "187955000000050117" }

      it { expect(described_class.find id).to eq expected_product }
    end

    context "when the product could not be found" do
      let(:id) { 0 }

      it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
    end
  end

  describe ".create" do
    let(:new_product_details) { { name: "Bazooka" } }

    it { expect(described_class.create new_product_details).to be_a Zoho::Subscriptions::Product }
  end

  describe "#update" do
    let(:id) { 187955000000050119 }
    let(:product) { described_class.find id }

    it {
      expect { product.update name: "Rocket Launcher" }.to(
        change(product, :name).from("Bazooka").to("Rocket Launcher")
      )
    }
  end

  describe "#destroy" do
    let(:id) { 187955000000050121 }
    let(:product) { described_class.find id }

    before { product.destroy }

    it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
  end
end
