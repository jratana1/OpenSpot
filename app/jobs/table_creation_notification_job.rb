# params = {"app_id" => "5eb5a37e-b458-11e3-ac11-000c2940e62c", 
#           "contents" => {"en" => "English Message"},
#           "channel_for_external_user_ids" => "push",
#           "include_external_user_ids" => ["6392d91a-b206-4b7b-a620-cd68e32c3a76","76ece62b-bcfe-468c-8a78-839aeaa8c5fa","8e0f21fa-9a5a-4ae7-a9a6-ca1f24294b86"]
#         }
# uri = URI.parse('https://onesignal.com/api/v1/notifications')
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = true

# request = Net::HTTP::Post.new(uri.path,
#                               'Content-Type'  => 'application/json;charset=utf-8',
#                               'Authorization' => "Basic NGEwMGZmMjItY2NkNy0xMWUzLTk5ZDUtMDAwYzI5NDBlNjJj")
# request.body = params.as_json.to_json
# response = http.request(request) 
# puts response.body

class TableCreationNotificationJob < ApplicationJob
    queue_as :default
  
    def perform(table)
      restaurant = table.restaurant


      params = {"app_id" => "#{ENV['ONESIGNAL_ID']}", 
          "contents" => {"en" => "#{restaurant.name} has a table available at #{table.seating}.  Click to Purchase!"},
          "channel_for_external_user_ids" => "push",
          # need to search all users that like the current restaurant
          "include_external_user_ids" => restaurant.liking_users.ids.map(&:to_s),
          "url" => "http://localhost:3001/#/checkout/#{table.id}"
        }
      uri = URI.parse('https://onesignal.com/api/v1/notifications')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path,
                                    'Content-Type'  => 'application/json;charset=utf-8',
                                    'Authorization' => "Basic #{ENV['ONESIGNAL_API_KEY']}")
      request.body = params.as_json.to_json
      response = http.request(request)
      puts response.body

    end

  end