class Marko::Client
  class Real
    def get_paging_token(from_date=nil)
      from_date ||= '2014-01-01'

      request(
        :path => '/activities/pagingtoken.json',
        :params => {'fromDate' => from_date }
      ).body['nextPageToken'].gsub(/#*$/, '')
    end
  end
end

