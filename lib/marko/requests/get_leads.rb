class Marko::Client
  class Real
    def get_leads(params={})
      path = params[:path] || "/leads.json"

      request(
        :path   => path,
        :params => params,
      )
    end
  end # Real

  class Mock
    def get_leads(params={})
      leads = self.data[:leads].values

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
