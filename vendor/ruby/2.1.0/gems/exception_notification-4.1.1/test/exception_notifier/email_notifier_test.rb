require 'test_helper'

class EmailNotifierTest < ActiveSupport::TestCase
  setup do
    Time.stubs(:current).returns('Sat, 20 Apr 2013 20:58:55 UTC +00:00')
    @email_notifier = ExceptionNotifier.registered_exception_notifier(:email)
    begin
      1/0
    rescue => e
      @exception = e
      @mail = @email_notifier.create_email(@exception,
        :data => {:job => 'DivideWorkerJob', :payload => '1/0', :message => 'My Custom Message'})
    end
  end

  test "should have default sender address overridden" do
    assert_equal @email_notifier.sender_address, %("Dummy Notifier" <dummynotifier@example.com>)
  end

  test "should have default exception recipients overridden" do
    assert_equal @email_notifier.exception_recipients, %w(dummyexceptions@example.com)
  end

  test "should have default email prefix overridden" do
    assert_equal @email_notifier.email_prefix, "[Dummy ERROR] "
  end

  test "should have default email headers overridden" do
    assert_equal @email_notifier.email_headers, { "X-Custom-Header" => "foobar"}
  end

  test "should have default sections overridden" do
    for section in %w(new_section request session environment backtrace)
      assert_includes @email_notifier.sections, section
    end
  end

  test "should have default background sections" do
    for section in %w(new_bkg_section backtrace data)
      assert_includes @email_notifier.background_sections, section
    end
  end

  test "should have email format by default" do
    assert_equal @email_notifier.email_format, :text
  end

  test "should have verbose subject by default" do
    assert @email_notifier.verbose_subject
  end

  test "should have normalize_subject false by default" do
    refute @email_notifier.normalize_subject
  end

  test "should have delivery_method nil by default" do
    assert_nil @email_notifier.delivery_method
  end

  test "should have mailer_settings nil by default" do
    assert_nil @email_notifier.mailer_settings
  end

  test "should have mailer_parent by default" do
    assert_equal @email_notifier.mailer_parent, 'ActionMailer::Base'
  end

  test "should have template_path by default" do
    assert_equal @email_notifier.template_path, 'exception_notifier'
  end

  test "should normalize multiple digits into one N" do
    assert_equal 'N foo N bar N baz N',
      ExceptionNotifier::EmailNotifier.normalize_digits('1 foo 12 bar 123 baz 1234')
  end

  test "mail should be plain text and UTF-8 enconded by default" do
    assert_equal @mail.content_type, "text/plain; charset=UTF-8"
  end

  test "should have raised an exception" do
    refute_nil @exception
  end

  test "should have generated a notification email" do
    refute_nil @mail
  end

  test "mail should have a from address set" do
    assert_equal @mail.from, ["dummynotifier@example.com"]
  end

  test "mail should have a to address set" do
    assert_equal @mail.to, ["dummyexceptions@example.com"]
  end

  test "mail should have a descriptive subject" do
    # On Rails < 4.1 the subject prefix has two spaces before the rest of the
    # subject content.
    if Gem::Version.new(ActionMailer::VERSION::STRING) < Gem::Version.new('4.1')
      prefix = '[Dummy ERROR]  '
    else
      # On Rails 4.1 the subject prefix has a single space.
      prefix = '[Dummy ERROR] '
    end
    assert_equal @mail.subject, prefix + '(ZeroDivisionError) "divided by 0"'
  end

  test "mail should say exception was raised in background at show timestamp" do
    assert_includes @mail.encoded, "A ZeroDivisionError occurred in background at #{Time.current}"
  end

  test "mail should prefix exception class with 'an' instead of 'a' when it starts with a vowel" do
    begin
      raise ActiveRecord::RecordNotFound
    rescue => e
      @vowel_exception = e
      @vowel_mail = @email_notifier.create_email(@vowel_exception)
    end

    assert_includes @vowel_mail.encoded, "An ActiveRecord::RecordNotFound occurred in background at #{Time.current}"
  end

  test "mail should contain backtrace in body" do
    assert @mail.encoded.include?("test/exception_notifier/email_notifier_test.rb:8"), "\n#{@mail.inspect}"
  end

  test "mail should contain data in body" do
    assert_includes @mail.encoded, '* data:'
    assert_includes @mail.encoded, ':payload=>"1/0"'
    assert_includes @mail.encoded, ':job=>"DivideWorkerJob"'
    assert_includes @mail.encoded, "My Custom Message"
  end

  test "mail should not contain any attachments" do
    assert_equal @mail.attachments, []
  end

  test "should not send notification if one of ignored exceptions" do
    begin
      raise ActiveRecord::RecordNotFound
    rescue => e
      @ignored_exception = e
      unless ExceptionNotifier.ignored_exceptions.include?(@ignored_exception.class.name)
        @ignored_mail = @email_notifier.create_email(@ignored_exception)
      end
    end

    assert_equal @ignored_exception.class.inspect, "ActiveRecord::RecordNotFound"
    assert_nil @ignored_mail
  end
end
