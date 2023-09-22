# frozen_string_literal: true

module Reach
  module REST
    # Page Base Class
    class Page
      include Enumerable

      META_KEYS = [
        'page',
        'pageSize',
        'totalPages',
        'outOfPageRange'
      ].freeze

      def initialize(url, version, response)
        payload = process_response(response)

        @url = url
        @version = version
        @payload = payload
        @solution = {}
        @records = load_page(payload)
      end

      def process_response(response)
        if response.status_code != 200
          raise Reach::REST::RestError.new('Unable to fetch page', response)
        end

        response.body
      end

      def load_page(payload)
        if payload['meta'] && payload['meta']['key']
          return payload[payload['meta']['key']]
        else
          keys = payload.keys
          key = keys - META_KEYS
          if key.size == 1
            return payload[key.first]
          end
          if key.size == 2
            key1 = key[0]
            key2 = key[1]
            if key1.length > key2.length
              aux = key2
              key2 = key1
              key1 = aux
            end
            val = "total" + key1[0,1].upcase + key1[1..-1]
            if val == key2
              return payload[key1]
            end
          end
        end

        raise Reach::REST::ReachError, 'Page Records can not be deserialized'
      end

      def previous_page_url
        page = 0
        if @payload.key?('page')
          page = @payload['page']
        end
        pageSize = 1
        if @payload.key?('pageSize')
          pageSize = @payload['pageSize']
        end
        if page > 0
          query = "pageSize=#{pageSize}&page=#{page-1}"
          uri = URI.parse(@url)
          if (!(uri.query == nil || uri.query.length == 0))
            query = uri.query + "&" + query
          end
          uri.query = query
          return uri.to_s
        end

        nil
      end

      def next_page_url
        page = 0
        if @payload.key?('page')
          page = @payload['page']
        end
        pageSize = 1
        if @payload.key?('pageSize')
          pageSize = @payload['pageSize']
        end
        outOfPageRange = true
        if @payload.key?('outOfPageRange')
          outOfPageRange = @payload['outOfPageRange']
        end
        totalPages = 1
        if @payload.key?('totalPages')
          totalPages = @payload['totalPages']
        end
        if !(outOfPageRange || (page + 1 >= totalPages))
          query = "pageSize=#{pageSize}&page=#{page+1}"
          uri = URI.parse(@url)
          if (!(uri.query == nil || uri.query.length == 0))
            query = uri.query + "&" + query
          end
          uri.query = query
          return uri.to_s
        end

        nil
      end

      def get_instance(payload)
        raise Reach::REST::ReachError, 'Page.get_instance() must be implemented in the derived class'
      end

      def previous_page
        return nil unless previous_page_url

        response = @version.domain.request('GET', previous_page_url)

        self.class.new(@url, @version, response, @solution)
      end

      def next_page
        return nil unless next_page_url

        response = @version.domain.request('GET', next_page_url)

        self.class.new(@url, @version, response, @solution)
      end

      def each
        @records.each do |record|
          yield get_instance(record)
        end
      end

      def to_s
        '#<Page>'
      end
    end
  end
end
