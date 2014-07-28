class Marko::Client
  class Real
    def get_campaigns(params={})
      request(
        :path   => "/campaigns.json",
        :params => params
      )
    end
  end # Real

  class Mock
    def get_campaigns(params={})
      campaigns = self.data[:campaigns].values

      response(
        :body     => {
          "requestId" => SecureRandom.hex,
          "sucess" => true,
          "result" => campaigns,
        },
        :status   => 200
      )
    end
  end # Mock
end # Marko::Client
