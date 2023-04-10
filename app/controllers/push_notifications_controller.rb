class PushNotificationsController < ApplicationController
  def send_sample_notification
    client = Exponent::Push::Client.new
    # client = Exponent::Push::Client.new(gzip: true)  # for compressed, faster requests

    random_number = rand(1000)

    messages = [
      {
        to: session[:expo_push_token], #"ExponentPushToken[lYq2h0FMhxmeZy5iCHTWog]",
        sound: "default",
        body: "Random number from server #{random_number}", 
        data: { url: phone_app_another_page_url(host: request.host, rand: random_number) }
      }
      # , {
      #   to: "ExponentPushToken[yyyyyyyyyyyyyyyyyyyyyy]",
      #   badge: 1,
      #   body: "You've got mail"
      # }
    ]

    # @Deprecated
    # client.publish(messages)

    # MAX 100 messages at a time
    handler = client.send_messages(messages)

    # Array of all errors returned from the API
    # puts handler.errors

    # you probably want to delay calling this because the service might take a few moments to send
    # I would recommend reading the expo documentation regarding delivery delays
    client.verify_deliveries(handler.receipt_ids)

    render json: { status: "Notifications has been sent"}
  end
end
