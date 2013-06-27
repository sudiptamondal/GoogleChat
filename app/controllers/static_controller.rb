class StaticController < ApplicationController
  require 'xmpp4r'
  def chat
    if request.post?

      sender_jid = Jabber::JID.new(params[:user][:email])
      client = Jabber::Client.new(sender_jid)
      client.connect('talk.google.com')
      client.auth(params[:user][:password])

      # client.send(Jabber::Presence.new.set_show(:chat)).set_status('my status')

      receiver_jid = Jabber::JID.new(params[:receiver][:email])
      message = Jabber::Message::new(receiver_jid, params[:receiver][:message]).set_type(:normal).set_id('1')
      client.send(message)
      

      client.add_message_callback do |message|
        begin
          @chat = Chat.create(
            :to           =>message.to.to_s.split('/').first,
            :message      =>message.body,
            :from         =>message.from.to_s.split('/').first,
            :message_read =>false
          )
        rescue Exception => e
          logger.debug e.inspect
          logger.debug "exception"  
        end
      end
      
      respond_to do |format|
        format.js
      end
    end
  end

  def reply
    @chats = Chat.where(:message_read=>false)
    logger.debug "zzzzzzzzzzzzzzzzzzzzz"
    logger.debug @chats.inspect
    logger.debug "zzzzzzzzzzzzzzzzzzzzzz"
    if @chats.blank?
      logger.debug "11111111111111"
      render :nothing => true
    else
      logger.debug "22222222222222"
      respond_to do |format|
        format.js
      end
    end
    Chat.where(:message_read=>false).update_all("message_read = 't'")
  end
end
