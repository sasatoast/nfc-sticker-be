require 'httparty'

module SupabaseClient
  SUPABASE_URL = ENV['SUPABASE_URL']
  SUPABASE_KEY = ENV['SUPABASE_SERVICE_KEY']
  
  if SUPABASE_URL.blank? || SUPABASE_KEY.blank?
    if Rails.env.production?
      raise "Supabase credentials are not set! Please check SUPABASE_URL and SUPABASE_SERVICE_KEY environment variables."
    else
      Rails.logger.warn "Supabase credentials are not set. Signed URLs will not work."
    end
  end
  
  def self.storage_url
    "#{SUPABASE_URL}/storage/v1"
  end
  
  def self.headers
    {
      'Authorization' => "Bearer #{SUPABASE_KEY}",
      'Content-Type' => 'application/json',
      'apikey' => SUPABASE_KEY
    }
  end
end

