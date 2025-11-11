class Supabase::SignedUrlGenerator
  include HTTParty

  def initialize(file_path, bucket, expires_in)
    @file_path = file_path
    @bucket = bucket
    @expires_in = expires_in.to_i
  end

  def self.call(file_path, bucket: "songs", expires_in: 15.minutes)
    new(file_path, bucket, expires_in).generate
  end

  def generate
    return nil if @file_path.blank?

    path = extract_storage_path(@file_path)

    response = HTTParty.post(
      "#{SupabaseClient.storage_url}/object/sign/#{@bucket}/#{path}",
      headers: SupabaseClient.headers,
      body: { expiresIn: @expires_in }.to_json
    )

    if response.success?

      signed_path = response.parsed_response["signedURL"]

      "#{SupabaseClient::SUPABASE_URL}#{signed_path}"
    else
      Rails.logger.error "Failed to generate signed URL for #{path}: #{response.code} - #{response.body}"

      @file_path
    end
  rescue StandardError => e
    Rails.logger.error "Error generating signed URL for #{@file_path}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")

    @file_path
  end

  private

  def extract_storage_path(url)
    return url unless url.start_with?("http")

    uri = URI.parse(url)
    path_parts = uri.path.split("/")

    bucket_index = path_parts.index("public") || path_parts.index("sign")
    if bucket_index
      path_parts[(bucket_index + 2)..-1].join("/")
    else
      url
    end
  rescue URI::InvalidURIError
    Rails.logger.warn "⚠️  Invalid URL format: #{url}"
    url
  end
end
