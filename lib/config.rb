module FFlogs
  # Your FFlogs public key
  PUBLIC_KEY = File.open("#{File.dirname(__FILE__)}/public.key", &:readline)
  # Base URL for the API
  # Do NOT edit if you don't know what you're doing
  API_URL = "https://www.fflogs.com:443/v1/"
end
