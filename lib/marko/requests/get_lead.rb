class Marko::Client
  class Real
    def get_lead(id)
      request(
        :path => "/lead/#{id}.json",
      )
    end
  end # Real

  class Mock
    def get_lead(id)
      lead = self.data[:leads][id]

      if lead
        response(
          :body     => {
            "requestId" => SecureRandom.hex,
            "success"   => true,
            "result"    => [
              lead,
            ],
          },
          :status   => 200
        )
      else
        response(
          :status   => 400
        )
      end
    end
  end # Mock
end # Marko::Client
