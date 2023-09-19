CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider:"Google",
    google_project: ENV['GOOGLE_PROJECT_ID'],
    google_json_key_location: ENV['GOOGLE_CLOUD_KEYFILE_PATH']
  }
  config.fog_directory = ENV['GOOGLE_CLOUD_BUCKET']
end