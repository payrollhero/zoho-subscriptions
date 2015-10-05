require "sinatra/base"

class FakeApi < Sinatra::Base

  class << self
    def request_history
      @request_history ||= []
    end
  end

  # Organizations

  get "/api/v1/organizations" do
    json_response 200, "organizations-get-200.json"
  end

  # Products

  get "/api/v1/products" do
    json_response 200, "products-get-200.json"
  end

  get "/api/v1/products/187955000000050117" do
    json_response 200, "products/187955000000050117-get-200.json"
  end

  post "/api/v1/products" do
    json_response 201, "products-post-201.json"
  end

  delete "/api/v1/products/187955000000050121" do
    json_response 200, "products/187955000000050121-delete-200.json"
  end

  get "/api/v1/products/187955000000050121" do
    case count_requests(request)
    when 0
      json_response 200, "products/187955000000050121-get-200.json"
    else
      json_response 400, "products/187955000000050121-get-400.json"
    end
  end

  get "/api/v1/products/187955000000050119" do
    json_response 200, "products/187955000000050119-get-200.json"
  end

  put "/api/v1/products/187955000000050119" do
    json_response 200, "products/187955000000050119-put-200.json"
  end

  get "/api/v1/products/0" do
    json_response 400, "products/0-get-400.json"
  end

  # Plans

  get "/api/v1/plans" do
    if params["product_id"].present?
      json_response 200, "plans-get-200-filtered.json"
    else
      json_response 200, "plans-get-200.json"
    end
  end

  post "/api/v1/plans" do
    json_response 201, "plans-post-201.json"
  end

  delete "/api/v1/plans/100-ammunition-per-month" do
    json_response 200, "plans/100-ammunition-per-month-delete-200.json"
  end

  get "/api/v1/plans/100-ammunition-per-month" do
    case count_requests(request)
    when 0
      json_response 200, "plans/100-ammunition-per-month-get-200.json"
    else
      json_response 400, "plans/100-ammunition-per-month-get-400.json"
    end
  end

  get "/api/v1/plans/100-ammunition" do
    json_response 200, "plans/100-ammunition-get-200.json"
  end

  put "/api/v1/plans/100-ammunition" do
    json_response 200, "plans/100-ammunition-put-200.json"
  end

  get "/api/v1/plans/0" do
    json_response 400, "plans/0-get-400.json"
  end

  # Addons

  get "/api/v1/addons" do
    json_response 200, "addons-get-200.json"
  end

  get "/api/v1/addons/target" do
    case count_requests(request)
    when 0
      json_response 200, "addons/target-get-200.json"
    else
      json_response 400, "addons/target-get-400.json"
    end
  end

  post "/api/v1/addons" do
    json_response 201, "addons-post-201.json"
  end

  put "/api/v1/addons/target" do
    json_response 200, "addons/target-put-200.json"
  end

  delete "/api/v1/addons/target" do
    json_response 200, "addons/target-delete-200.json"
  end

  get "/api/v1/addons/0" do
    json_response 400, "addons/0-get-400.json"
  end

  # Customers

  get "/api/v1/customers" do
    json_response 200, "customers-get-200.json"
  end

  get "/api/v1/customers/187955000000050049" do
    json_response 200, "customers/187955000000050049-get-200.json"
  end

  post "/api/v1/customers" do
    json_response 201, "customers-post-201.json"
  end

  delete "/api/v1/customers/187955000000050083" do
    json_response 200, "customers/187955000000050083-delete-200.json"
  end

  get "/api/v1/customers/187955000000050083" do
    case count_requests(request)
    when 0
      json_response 200, "customers/187955000000050083-get-200.json"
    else
      json_response 400, "customers/187955000000050083-get-400.json"
    end
  end

  get "/api/v1/customers/187955000000050001" do
    json_response 200, "customers/187955000000050001-get-200.json"
  end

  put "/api/v1/customers/187955000000050001" do
    json_response 200, "customers/187955000000050001-put-200.json"
  end

  get "/api/v1/customers/0" do
    json_response 400, "customers/0-get-400.json"
  end

  # Subscriptions

  get "/api/v1/subscriptions" do
    json_response 200, "subscriptions-get-200.json"
  end

  get "/api/v1/subscriptions/187955000000053082" do
    json_response 200, "subscriptions/187955000000053082-get-200.json"
  end

  post "/api/v1/subscriptions" do
    json_response 201, "subscriptions-post-201.json"
  end

  put "/api/v1/subscriptions/187955000000053082" do
    json_response 200, "subscriptions/187955000000053082-put-200.json"
  end

  get "/api/v1/subscriptions/0" do
    json_response 404, "subscriptions/0-get-404.json"
  end

  get "/api/v1/subscriptions/187955000000053196" do
    json_response 200, "subscriptions/187955000000053196-get-200.json"
  end

  post "/api/v1/subscriptions/187955000000053196/cancel" do
    json_response 200, "subscriptions/187955000000053196/cancel-post-200.json"
  end

  # catch all
  [:get, :post, :put, :delete].each do |http_method|
    send http_method, "/*" do
      raise ArgumentError, "no fake API route found for: #{http_method} #{request.path}"
    end
  end

  after do
    self.class.request_history << request
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code

    File.read("spec/fixtures/responses/#{file_name}")
  end

  def count_requests(request)
    self.class.request_history.count do |requested|
      request.path == requested.path && request.request_method == requested.request_method
    end
  end
end
