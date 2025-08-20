require "test_helper"

class UserTest < MongoidTestCase
  def setup
    super
    @user = User.new(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  def test_valid_with_valid_attributes
    assert @user.valid?
  end

  def test_require_email
    @user.email = nil
    refute @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  def test_not_allow_duplicate_emails
    @user.save!
    duplicate_user = User.new(
      email: @user.email,
      password: "different123",
      password_confirmation: "different123"
    )
    refute duplicate_user.valid?
  end

  def test_require_password
    user = User.new(email: "test2@example.com")
    refute user.valid?
  end

  def test_have_many_messages
    assert @user.respond_to?(:messages)
  end
end
