class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)

    if ModerationService.contains_ng_word?(@message.content)
      @message.errors.add(:content, "にNGワードが含まれています")
      @messages = @room.messages.order(created_at: :asc)
      render "rooms/show", status: :unprocessable_entity
      return
    end

    if@message.save
      redirect_to room_path(@room),notion:"メッセージを送信しました。"
    else
      @messages = @room.messages.order(create_at: :asc)
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:author_name, :content)
  end
end


