require 'test_helper'

class RackTest < ActiveSupport::TestCase

  setup do
    @pass_app = Object.new
    @pass_app.stubs(:call).returns([nil, { 'X-Cascade' => 'pass' }, nil])
  end

  test "should ignore \"X-Cascade\" header by default" do
    ExceptionNotifier.expects(:notify_exception).never
    ExceptionNotification::Rack.new(@pass_app).call({})
  end

  test "should notify on \"X-Cascade\" = \"pass\" if ignore_cascade_pass option is false" do
    ExceptionNotifier.expects(:notify_exception).once
    ExceptionNotification::Rack.new(@pass_app, :ignore_cascade_pass => false).call({})
  end

end
