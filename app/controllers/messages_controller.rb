class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)

    if ModerationService.contains_ng_word?(@message.content)
      @message.errors.add(:content, "にNGワードが含まれています")
      render_room_with_errors
      return
    end

    if @message.save
      redirect_to room_path(@room), notice: "メッセージを送信しました。"
    else
      render_room_with_errors
    end
  end

  private

  def message_params
    params.require(:message).permit(:author_name, :content)
  end

  def render_room_with_errors
    @query = params[:query]
    @messages = @room.messages.order(created_at: :asc)
    render "rooms/show", status: :unprocessable_content
  end
end
