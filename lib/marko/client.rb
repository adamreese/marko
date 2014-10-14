class Marko::Client < Cistern::Service

  model_path "marko/models"
  collection_path "marko/collections"
  request_path "marko/requests"

  model :activity
  collection :activities
  request :get_activities

  model :activity_type
  collection :activity_types
  request :get_activity_types

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

  model :lead_change
  collection :lead_changes
  request :get_lead_changes

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
    def initialize(options={})
      @url         = options[:url] || ENV["MARKETO_URL"] || Marko.defaults[:url]
      @api_version = options[:version] || "v1"
      @logger      = options[:logger] || Logger.new(nil)
    end

    def self.data
      @data ||= begin
                  list_id         = marketo_id
                  campaign_id     = marketo_id
                  lead_change_id  = marketo_id
                  activity_id     = marketo_id

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

                  lead_change = {
                    "id"             => lead_change_id,
                    "leadId"         => "775",
                    "activityDate"   => "2014-09-17T22:31:49+0000",
                    "activityTypeId" => "13",
                    "fields" => [
                      {
                        "id"       => "48",
                        "name"     => "firstName",
                        "newValue" => "FirstName_6176",
                        "oldValue" => "FirstName_4914"
                      }
                    ],
                    "attributes" => [
                      {
                        "name"  => "Reason",
                        "value" => "Web service API"
                      },
                      {
                        "name"  => "Source",
                        "value" => "Web service API"
                      },
                      {
                        "name"  => "Lead ID",
                        "value" => "775"
                      }
                    ]
                  }

                  activity = {
                    "id"                      => activity_id,
                    "leadId"                  => '6',
                    "activityDate"            => "2013-09-26T06:56:35+0000",
                    "activityTypeId"          => "12",
                    "primaryAttributeValueId" => "6",
                    "primaryAttributeValue"   => "Owyliphys Iledil",
                    "attributes" => [
                      {
                        "name"  => "Source Type",
                        "value" => "Web page visit"
                      },
                      {
                        "name"  => "Source Info",
                        "value" => "http://search.yahoo.com/search?p=train+cappuccino+army"
                      }
                    ]
                  }

                  {
                    :leads        => {},
                    :lists        => {list_id => list},
                    :campaigns    => {campaign_id => campaign},
                    :lead_changes => {lead_change_id => lead_change},
                    :activities   => {activity_id => activity},
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
