if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAIX73GSO23S4D2WJA'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['shc_pms']
  end
end
