require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  ACCOUNT_SID = ENV["ACCOUNT_SID"]
	AUTH_TOKEN = ENV["AUTH_TOKEN"]

  after_filter :set_header

  def voice
    response = Twilio::TwiML::Response.new do |response|
      response.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
        response.Play 'http://linode.rabasa.com/cantina.mp3'
	  end
	end

  def text
  	User.where(:id => params[:receivers]).each do |roommates|
      @body = (params[:message]) << "\n    - #{roommates.name} " "#{roommates.phone_number}"
  		client.account.messages.create(
  			:from => "(818) 926-4291", # phone number REQUIRED by twilio API
  			:to   => roommates.phone_number,
  			:body => @body
  		)
  	end
  	redirect_to users_path
  end

  private
  def client
  	Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end
end