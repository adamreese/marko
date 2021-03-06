class Marko::Client
  class Real
    def get_lead_changes(params={})

      params.fetch(:next_page_token, get_paging_token)

      request(
        :path   => '/activities/leadchanges.json',
        :params => params
      )
    end
  end

  class Mock
    def get_lead_changes(params={})

      lead_changes = self.data[:lead_changes].values

      response(
        :body     => {
          "requestId" => SecureRandom.hex,
          "sucess" => true,
          "result" => lead_changes,
        },
        :status   => 200
      )
    end
  end
end
