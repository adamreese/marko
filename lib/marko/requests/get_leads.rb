class Marko::Client
  class Real
    def get_leads(params={})
      path = params.delete(:path) || "/leads.json"

      params = {
        "filterType" => params.keys.first,
        "filterValues" => params.values.first.to_a.join(",")
      } || {}

      request(
        :path   => path,
        :params => params,
      )
    end
  end # Real

  class Mock
    def get_leads(params={})
      path = params.delete(:path) || "/leads.json"

      if filter_type = params.keys.first.to_s
        leads = self.data[:leads].values.find_all{|i| i[filter_type] == params.values.first}
      else
        leads = self.data[:leads].values
      end

      response(
        :body     => {
          "requestId" => SecureRandom.hex,
          "sucess" => true,
          "result" => leads,
          "nextPageToken" => SecureRandom.hex,
        },
        :status   => 200
      )
    end
  end # Mock
end # Marko::Client
