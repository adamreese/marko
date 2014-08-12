class Marko::Client
  class Real
    def get_leads(params={})
      path = params.delete(:path) || "/leads.json"

      # we are assuming that any params other than path are the filter params
      raise "Too many parameters" if params.size > 1

      options = {}
      if params.size > 0
        filter_type, filter_values = params.first

        options.merge(
          "filterType"   => filter_type,
          "filterValues" => Array(filter_values).join(","),
        )
      end

      request(
        :path   => path,
        :params => options,
      )
    end
  end # Real

  class Mock
    def get_leads(params={})
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
