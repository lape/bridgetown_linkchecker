# frozen_string_literal: true

require "nokogiri"

module BridgetownLinkchecker
  class Builder < Bridgetown::Builder
    def build
      hook :posts, :post_render do |post|
        # Parse the HTML content with Nokogiri
        parsed_document = Nokogiri::HTML(post.content)

        # Extract the href attributes from all the <a> tags
        links = parsed_document.css("a").filter_map { |link| link["href"] }
        links.each do |link|
          # Check if the link is an external link
          if link.start_with?("http") && !link_valid?(link)
            Bridgetown.logger.info "Broken link:", "❌ #{link} (on '#{post.data["title"]}')"
          end
        end
      end
    end

    def link_valid?(link)
      uri = URI.parse(link.strip)
      request = Net::HTTP.new(uri.host, uri.port)
      request.use_ssl = (uri.scheme == "https")
      path = uri.path unless uri.path.empty?
      response = request.request_head(path || "/")
      response_code = response.code.to_i
      [200, 301].include?(response_code)
    rescue StandardError
      false
    end
  end
end
