require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should get show" do
    get room_url(rooms(:one))
    assert_response :success
  end

  test "should search messages in room" do
    room = rooms(:one)
    room.messages.create!(author_name: "Alice", content: "find me")
    room.messages.create!(author_name: "Bob", content: "another message")

    get room_url(room), params: { query: "find" }

    assert_response :success
    assert_includes response.body, "find me"
    refute_includes response.body, "another message"
  end

  test "should get new" do
    get new_room_url
    assert_response :success
  end

  test "should create room" do
    assert_difference("Room.count") do
      post rooms_url, params: { room: { name: "Test room" } }
    end

    assert_redirected_to room_url(Room.last)
  end
end
