require "test_helper"

class MessageTest < MongoidTestCase
  def setup
    super
    @user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    @message = Message.new(
      to_phone_number: "+14155552671",
      content: "Hello, this is a test message",
      user: @user
    )
  end

  def test_valid_with_valid_attributes
    assert @message.valid?
  end

  def test_require_to_phone_number
    @message.to_phone_number = nil
    refute @message.valid?
    assert_includes @message.errors[:to_phone_number], "can't be blank"
  end

  def test_validate_to_phone_number_format
    @message.to_phone_number = "1234567890" # Invalid format
    refute @message.valid?
    assert_includes @message.errors[:to_phone_number], "must be in E.164 format (e.g., +14155552671)"
  end

  def test_require_content
    @message.content = nil
    refute @message.valid?
    assert_includes @message.errors[:content], "can't be blank"
  end

  def test_content_length_validation
    @message.content = "a" * 251
    refute @message.valid?
    assert_includes @message.errors[:content], "must not exceed 250 characters"
  end

  def test_require_user
    @message.user = nil
    refute @message.valid?
    assert_includes @message.errors[:user], "can't be blank"
  end

  def test_default_status_is_queued
    assert_equal 'queued', @message.status
  end

  def test_auto_sets_from_phone_number
    assert_nil @message.from_phone_number
    @message.valid?
    assert_equal Rails.application.config.x.twilio[:phone_number], @message.from_phone_number
  end

  def test_belongs_to_user
    assert_equal @user, @message.user
  end

  def test_content_allows_emoji_and_punctuation
    @message.content = "Hello! How are you? 👋 🎉 Here's a test... Let's go!"
    assert @message.valid?, "Message should be valid with emojis and punctuation"
  end
end
