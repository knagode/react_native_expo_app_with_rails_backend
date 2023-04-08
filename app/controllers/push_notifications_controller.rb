class PushNotificationsController < ApplicationController
  def send_sample_notification
    client = Exponent::Push::Client.new
    # client = Exponent::Push::Client.new(gzip: true)  # for compressed, faster requests

    messages = [
      {
        to: "ExponentPushToken[lYq2h0FMhxmeZy5iCHTWog]",
        sound: "default",
        body: "Hello world!", 
        data: { url: "https://google.com" }
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
