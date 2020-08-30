require 'net/http'
require 'addressable/uri'

class RecipeCreateForm
    include ActiveModel::Validations
  
    attr_accessor :url

    validates :url, presence: true, length: { maximum: 255 }
    validate :validate_url
    validate :recipe_cite_url?
  
    def apply(params)
        @url = params[:url]
    end

    def to_attributes
        {
            url: @url
        }
    end

    private def recipe_cite_url?
      uri = Addressable::URI.parse(@url)
      unless uri.present?
        # errors.add(:validate_url, '無効なURLです')
      else        
        host = uri.host.downcase
        unless Recipecite.find_by(host: host)
          errors.add(:is_not_recipecite, "レシピサイトとして登録されていません")
        end
      end
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