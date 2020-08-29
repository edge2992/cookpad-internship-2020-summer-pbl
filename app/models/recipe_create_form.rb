require 'net/http'

class RecipeCreateForm
    include ActiveModel::Model
  
    attr_accessor :title, :url

    validates :title, presence: true, length: { maximum: 255 }
    validates :url, presence: true, length: { maximum: 255 }
    validate :validate_url
  
    def apply(params)
        @title = params[:title]
        @url = params[:url]
    end

    def to_attributes
        {
            title: @title,
            url: @url
        }
    end

    private def validate_url
        unless URI.regexp.match(@url)
            errors.add(:validate_url, '無効なURLです')
        end
    end

    private def url_exist?(url)
        res = ->(url) {
          begin
            uri = URI.parse(url)
            uri_path = uri.path.empty? ? "/" : uri.path
            Net::HTTP.start(uri.host, uri.port, use_ssl: (uri.scheme == 'https')) { |http| http.get(uri_path) }
          rescue TypeError, SocketError, URI::InvalidURIError
            false
          end
        }
        !url.nil? && !url.empty? && (Net::HTTPSuccess === res.call(url) || Net::HTTPRedirection === res.call(url))
      end


  end