class RoomsController < ApplicationController
  def index
    @rooms = Room.order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.order(created_at: :asc)
    @message = Message.new
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room, notice: "ルームを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
