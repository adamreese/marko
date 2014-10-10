class Marko::Client < Cistern::Service

  model_path "marko/models"
  collection_path "marko/collections"
  request_path "marko/requests"

  model :campaign
  collection :campaigns
  request :get_campaign
  request :get_campaigns

  model :list
  collection :lists
  request :get_list
  request :get_lists

  model :lead
  collection :leads
  request :create_lead
  request :get_lead
  request :get_leads
  request :update_lead

  recognizes :client_id, :client_secret, :url, :logger, :token

  class Real
    def initialize(options={})

      @url         = options[:url] || ENV["MARKETO_URL"] || Marko.defaults[:url]
      @api_version = options[:version] || "v1"
      @logger      = options[:logger] || Logger.new(nil)
      @token       = options[:token] || ENV["MARKETO_TOKEN"] || authenticate!

    end

    def setup_connection
      @connection = Faraday.new(url: @url) do |builder|
        # response
        builder.response :json

        # request
        builder.request :multipart
        builder.request :json

        builder.use Marko::Authorization, @token

        builder.use Marko::Logger, @logger

        builder.adapter Faraday.default_adapter
      end
    end

    def request(options={})
      setup_connection unless @connection

      method  = options[:method] || :get
      url     = options[:url] || URI.parse(File.join(@url.to_s, "rest", @api_version, options[:path]))
      params  = options[:params] || {}
      body    = options[:body]
      headers = options[:headers] || {"Accept" => "application/json"}
      headers.merge!("Content-Type" => "application/json") if !body && !params.empty?

      response = @connection.send(method) do |req|
        req.url(url)
        req.headers.merge!(headers)
        req.params.merge!(params)
        req.body = body
      end

      Marko::Response.new(
        :status  => response.status,
        :headers => response.headers,
        :body    => response.body,
        :request => {
          :method => method,
          :url    => url,
        }
      ).raise!
    end

    def authenticate!(options={})
      credentials = {}
      credentials["client_id"]     = ENV["CLIENT_ID"] || Marko.defaults[:client_id]
      credentials["client_secret"] = ENV["CLIENT_SECRET"] || Marko.defaults[:client_secret]

      @token = request(method: :post, url: File.join(@url, "identity/oauth/token"), params: credentials.merge("grant_type" => "client_credentials")).body["access_token"]

      setup_connection
    end
  end # Real

  class Mock

    def self.data
      @data ||= begin
                  list_id      = marketo_id
                  campaign_id  = marketo_id

                  list = {
                    "id"             => list_id,
                    "name"           => "Mobile First No Shows",
                    "program_name"   => "EVNT-TRD-13-12-04-Mobile-First-Mobile-Only",
                    "workspace_name" => "Default",
                    "created_at"     => "2013-12-19T23:56:39+0000",
                    "updated_at"     => "2013-12-20T00:02:00+0000"
                  }

                  campaign = {
                    "id"          => campaign_id,
                    "name"        => "Cammpaign Name",
                    "description" => "desc",
                    "programName" => "ProgramName",
                    "createdAt"   => "2014-03-26T17:29:14+0000",
                    "updatedAt"   => "2014-03-26T18:04:10+0000"
                  }

                  {
                    :leads => {},
                    :lists => {list_id => list},
                    :campaigns => {campaign_id => campaign},
                  }
                end
    end

    def data
      self.class.data
    end

    def self.marketo_id
      SecureRandom.hex(9)
    end
    def marketo_id; self.class.marketo_id; end

    def self.reset!
      @data = nil
    end

    def response(options={})
      method  = (options[:method] || :get).to_s.to_sym
      url     = options[:url] || File.join(@url.to_s, "rest", @api_version, options[:path] || "/")
      status  = options[:status] || 200
      body    = options[:body]
      headers = {
        "Content-Type"  => "application/json; charset=utf-8"
      }.merge(options[:headers] || {})

      Marko::Response.new(
        :status  => status,
        :headers => headers,
        :body    => body,
        :request => {
          :method => method,
          :url    => url,
        }
      ).raise!
    end
  end # Mock
end
