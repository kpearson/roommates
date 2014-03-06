require 'twilio-ruby'
 
class TwilioController < ApplicationController
  include Webhookable

  ACCOUNT_SID = ENV["ACCOUNT_SID"]
	AUTH_TOKEN = ENV["AUTH_TOKEN"]
 
  after_filter :set_header
 
  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
         r.Play 'http://linode.rabasa.com/cantina.mp3'
	  end
	end

  def text
  	send_all = User.all.each do |u|
  		client.account.messages.create(
  			:from => "(818) 926-4291",
  			:to   => u.phone_number,
  			:body => "Test message."
  			)
  	end
  	redirect_to users_path
  end

  private
  def client
  	Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end
end
