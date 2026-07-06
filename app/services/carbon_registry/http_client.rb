module CarbonRegistry
  class HttpClient
    BASE_URL = "https://api.apify.com/v2"
    DATASET_ID = ENV.fetch("APIFY_DATASET_ID")

    def self.client
      @client ||= Faraday.new(url: BASE_URL) do |f|
        f.request :url_encoded
        f.response :raise_error
        f.adapter Faraday.default_adapter
      end
    end

    def self.fetch_items(limit: 100)
      path = "datasets/#{DATASET_ID}/items"

      response = client.get(path) do |req|
        req.params["limit"] = limit
        req.headers["Authorization"] = "Bearer #{ENV.fetch("APIFY_API_TOKEN")}"
      end

      JSON.parse(response.body)
    rescue Faraday::Error => e
      Rails.logger.error("Apify API error: #{e.message}")
      raise e
    end
  end
end
