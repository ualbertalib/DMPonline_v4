require 'test_helper'
require 'slack-notifier'

class SlackNotifierTest < ActiveSupport::TestCase

  def setup
    @exception = fake_exception
    @exception.stubs(:backtrace).returns(["backtrace line 1", "backtrace line 2"])
    @exception.stubs(:message).returns('exception message')
  end

  test "should send a slack notification if properly configured" do
    options = {
      webhook_url: "http://slack.webhook.url"
    }

    Slack::Notifier.any_instance.expects(:ping).with(fake_notification, {})

    slack_notifier = ExceptionNotifier::SlackNotifier.new(options)
    slack_notifier.call(@exception)
  end

  test "should send the notification to the specified channel" do
    options = {
      webhook_url: "http://slack.webhook.url",
      channel: "channel"
    }

    Slack::Notifier.any_instance.expects(:ping).with(fake_notification, {})

    slack_notifier = ExceptionNotifier::SlackNotifier.new(options)
    slack_notifier.call(@exception)

    assert_equal slack_notifier.notifier.channel, options[:channel]
  end

  test "should send the notification to the specified username" do
    options = {
      webhook_url: "http://slack.webhook.url",
      username: "username"
    }

    Slack::Notifier.any_instance.expects(:ping).with(fake_notification, {})

    slack_notifier = ExceptionNotifier::SlackNotifier.new(options)
    slack_notifier.call(@exception)

    assert_equal slack_notifier.notifier.username, options[:username]
  end

  test "should pass the additional parameters to Slack::Notifier.ping" do
    options = {
      webhook_url: "http://slack.webhook.url",
      username: "test",
      custom_hook: "hook",
      additional_parameters: {
        icon_url: "icon",
      }
    }

    Slack::Notifier.any_instance.expects(:ping).with(fake_notification, {icon_url: "icon"})

    slack_notifier = ExceptionNotifier::SlackNotifier.new(options)
    slack_notifier.call(@exception)
  end

  test "shouldn't send a slack notification if webhook url is missing" do
    options = {}

    slack_notifier = ExceptionNotifier::SlackNotifier.new(options)

    assert_nil slack_notifier.notifier
    assert_nil slack_notifier.call(fake_exception)
  end

  test "should pass along environment data" do
    options = {
      webhook_url: "http://slack.webhook.url",
      ignore_data_if: lambda {|k,v|
        "#{k}" == 'key_to_be_ignored' || v.is_a?(Hash)
      }
    }

    notification_options = {
      env: {
        'exception_notifier.exception_data' => {foo: 'bar', john: 'doe'}
      },
      data: {
        'user_id'           => 5,
        'key_to_be_ignored' => 'whatever',
        'ignore_as_well'    => {what: 'ever'}
      }
    }

    expected_data_string = 'foo: bar, john: doe, user_id: 5'

    Slack::Notifier.any_instance.expects(:ping).with(fake_notification(@exception, expected_data_string), {})
    slack_notifier = ExceptionNotifier::SlackNotifier.new(options)
    slack_notifier.call(@exception, notification_options)
  end

  private

  def fake_exception
    begin
      5/0
    rescue Exception => e
      e
    end
  end

  def fake_notification(exception=@exception, data_string=nil)
    message = "An exception occurred: '#{exception.message}' on '#{exception.backtrace.first}'\n"
    message += "*Data:*\n#{data_string}\n" unless data_string.nil?
    message += "*Backtrace:*\n" + exception.backtrace.join("\n")
  end
end
