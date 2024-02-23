# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ['https://jndrkmllh.github.io', 'http://localhost:4000'] # Add your GitHub Pages URL or whatever domain you want to use to fetch data
    resource '*', headers: :any, methods: [:get, :options, :head]
  end
end
