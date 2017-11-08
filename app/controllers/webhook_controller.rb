class WebhookController < ApplicationController
  protect_from_forgery with: :null_session

  def callback
    res = reply(params)
    render :nothing => true, status: :ok
  end

  private
  def reply(params)
    response_service = response_service(params)
    response_text, reply_token = response_service.form_response
    line_client.reply(reply_token, response_text) if response_text.present?
  end

  def response_service(input_text)
    ResponseService.new(input_text)
  end

  def line_client
    @line_client ||= LineClient.new
  end
end