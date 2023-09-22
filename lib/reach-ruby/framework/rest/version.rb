# frozen_string_literal: true

module Reach
  module REST
    class Version
      attr_accessor :domain

      class RecordStream
        include Enumerable

        def initialize(page, limit: nil, page_limit: nil)
          @page = page
          @limit = limit
          @page_limit = page_limit
        end

        def each
          current_record = 0
          current_page = 1

          while @page
            @page.each do |record|
              yield record
              current_record += 1
              return nil if @limit && @limit <= current_record
            end

            return nil if @page_limit && @page_limit <= current_page

            @page = @page.next_page
            current_page += 1
          end
        end
      end

      def initialize(domain)
        @domain = domain
        @version = nil
      end

      def absolute_url(uri)
        @domain.absolute_url(relative_uri(uri))
      end

      def url_without_pagination_info(url, params = {})
        uri = URI.parse(url)
        clo = params.clone
        clo = clo.delete_if { |_k, v| v.nil? }
        query = clo.map{|k, v| "#{k}=#{v}"}.join("&")
        if (!(uri.query == nil || uri.query.length == 0))
          sep = ""
          if (query.length>0)
            sep = "&"
          end
          query = uri.query + sep + query;
        end
        if (query.length ==0)
          return url
        end
        queryParams = query.split("&")
        idx = 0;
        q = ["page", "pageSize"];
        while (idx < q.length)
          par = q[idx]
          prefix = par + "="
          i = 0
          while (i < queryParams.length)
            if (queryParams[i].start_with?(prefix))
                queryParams.delete_at(i)
            else
                i = i + 1
            end
          end
          idx = idx + 1
        end
        query = ""
        if (queryParams.length > 0)
          query = queryParams.join("&")
        end
        uri.query = query
        return uri.to_s
      end

      def relative_uri(uri)
        "#{@version.chomp('/').gsub(/^\//, '')}/#{uri.chomp('/').gsub(/^\//, '')}"
      end

      def request(method, uri, params = {}, data = {}, headers = {}, auth = nil, timeout = nil)
        url = relative_uri(uri)
        params = params.delete_if { |_k, v| v.nil? }
        data = data
        @domain.request(method, url, params, data, headers, auth, timeout)
      end

      def exception(response, header)
        Reach::REST::RestError.new(header, response)
      end

      def fetch(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(
          method,
          uri,
          params,
          data,
          headers,
          auth,
          timeout
        )

        # Note that 3XX response codes are allowed for fetches.
        if response.status_code < 200 || response.status_code >= 400
          raise exception(response, 'Unable to fetch record')
        end

        response.body
      end

      def update(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(
          method,
          uri,
          params,
          data,
          headers,
          auth,
          timeout
        )

        if response.status_code < 200 || response.status_code >= 300
          raise exception(response, 'Unable to update record')
        end

        response.body
      end

      def unschedule(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(
          method,
          uri,
          params,
          data,
          headers,
          auth,
          timeout
        )

        if response.status_code < 200 || response.status_code >= 300
          raise exception(response, 'Unable to unschedule record')
        end

        response.body
      end

      def delete(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(
          method,
          uri,
          params,
          data,
          headers,
          auth,
          timeout
        )

        if response.status_code < 200 || response.status_code >= 300
          raise exception(response, 'Unable to delete record')
        end

        response.status_code == 204
      end

      def read_limits(limit = nil, page_size = nil)
        unless limit.nil? || page_size
          page_size = limit
        end

        {
          limit: limit || nil,
          page_size: page_size || nil
        }
      end

      def page(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        request(
          method,
          uri,
          params,
          data,
          headers,
          auth,
          timeout
        )
      end

      def stream(page, limit: nil, page_limit: nil)
        RecordStream.new(page, limit: limit, page_limit: page_limit)
      end

      def create(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(method, uri, params, data, headers, auth, timeout)

        if response.status_code < 200 || response.status_code >= 300
          raise exception(response, 'Unable to create record')
        end

        response.body
      end

      def dispatch(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(method, uri, params, data, headers, auth, timeout)

        if response.status_code < 200 || response.status_code >= 300
          raise exception(response, 'Unable to dispatch record')
        end

        response.body
      end

      def start(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(method, uri, params, data, headers, auth, timeout)

        if response.status_code < 200 || response.status_code >= 300
          raise exception(response, 'Unable to start record')
        end

        response.body
      end

      def check(method, uri, params: {}, data: {}, headers: {}, auth: nil, timeout: nil)
        response = request(method, uri, params, data, headers, auth, timeout)

        if response.status_code < 200 || response.status_code >= 300
          raise exception(response, 'Unable to check record')
        end

        response.body
      end
    end
  end
end
