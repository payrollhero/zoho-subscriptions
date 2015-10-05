require "spec_helper"

describe Zoho::Subscriptions::Subscription do
  subject(:subscription) { described_class.find id }

  describe ".all" do
    let(:all_subscriptions) { described_class.all }

    example {
      expect(all_subscriptions.count).to eq 2
      expect(all_subscriptions.first).to be_a Zoho::Subscriptions::Subscription
      expect(all_subscriptions.last).to be_a Zoho::Subscriptions::Subscription
    }
  end

  describe ".find" do
    context "when the subscription exists" do
      let(:id) { 187955000000053082 }
      let(:expected_subscription) { described_class.new id: "187955000000053082" }

      it { expect(described_class.find id).to eq expected_subscription }
    end

    context "when the subscription could not be found" do
      let(:id) { 0 }

      it { expect { described_class.find id }.to raise_error Zoho::Subscriptions::Errors::NotFound }
    end
  end

  describe ".create" do
    let(:new_subscription_details) {
      {
        customer_id: 187955000000053001,
        auto_collect: false,
        plan: { plan_code: "100-ammunition" }
      }
    }

    it { expect(described_class.create new_subscription_details).to be_a Zoho::Subscriptions::Subscription }
  end

  describe "#update" do
    let(:id) { 187955000000053082 }
    let(:subscription) { described_class.find id }

    let(:new_subscription_details) {
      {
        plan: { plan_code: "100-ammunition", quantity: 10 },
        prorate: true
      }
    }

    it {
      expect { subscription.update new_subscription_details }.to(
        change { subscription.plan["quantity"] }.from(1).to(10)
      )
    }
  end

  describe "#cancel" do
    let(:id) { 187955000000053196 }

    it {
      expect { subscription.cancel cancel_at_end: false }.to(
        change(subscription, :status).from("live").to("cancelled")
      )
    }
  end
end
