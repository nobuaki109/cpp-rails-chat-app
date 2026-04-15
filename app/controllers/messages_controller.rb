class MessagesController < ApplicationController
  def create
    @room = Room.find(paramas[:room_id])
    @message = @room.messages.build(message_params)

    if@message.save
      redirect_to room_path(@room),notion:"メッセージを送信しました。"
    else
      @messages = @room.messages.order(create_at: :asc)
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    paramas.require(:message).permit(:author_name, :content)
  end
end


