require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should create message" do
    room = rooms(:one)

    assert_difference("Message.count") do
      post room_messages_url(room), params: {
        message: {
          author_name: "Test user",
          content: "Hello"
        }
      }
    end

    assert_redirected_to room_url(room)
  end

  test "should not create invalid message" do
    room = rooms(:one)

    assert_no_difference("Message.count") do
      post room_messages_url(room), params: {
        message: {
          author_name: "",
          content: ""
        }
      }
    end

    assert_response :unprocessable_content
    assert_includes response.body, "エラーがあります"
  end
end
