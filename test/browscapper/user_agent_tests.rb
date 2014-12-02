# encoding: BINARY

$: << File.dirname(__FILE__)
require 'test_helper'

class Browscapper::UserAgentTest < MiniTest::Unit::TestCase
  def test_eqeq_equal
    a = Browscapper::UserAgent.new(tablet: :foo)
    b = Browscapper::UserAgent.new(tablet: :foo)

    assert(a == b)
  end

  def test_eqeq_not_equal
    a = Browscapper::UserAgent.new(tablet: true)
    b = Browscapper::UserAgent.new(tablet: :foo)

    refute(a == b)
  end

  def test_eqeq_not_a_user_agent
    a = Browscapper::UserAgent.new(tablet: true)

    refute(a == nil)
    refute(a == :foo)
  end
end
