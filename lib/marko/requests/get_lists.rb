class Marko::Client
  class Real
    def get_lists(params={})
      request(
        :path   => "/lists.json",
        :params => params
      )
    end
  end # Real

  class Mock
    def get_lists(params={})
      lists = self.data[:lists].values

      response(
        :body     => {
          "requestId" => SecureRandom.hex,
          "sucess" => true,
          "result" => lists,
        },
        :status   => 200
      )
    end
  end # Mock
end # Marko::Client
