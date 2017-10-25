# encoding: BINARY

$: << File.dirname(__FILE__)
require 'test_helper'

class BrowscapperTest < Minitest::Test
  FIREFOX_ON_OSX = Browscapper::UserAgent.new({
    :activex_controls => false,
    :alpha => false,
    :aol_version => 0,
    :background_sounds => false,
    :beta => false,
    :browser => "Firefox",
    :comment => "Firefox 3.6",
    :cookies => true,
    :crawler => false,
    :css_version => 3,
    :device_name => "Macintosh",
    :device_maker => "Apple Inc",
    :frames => true,
    :iframes => true,
    :java_applets => true,
    :javascript => true,
    :major_version => 3,
    :minor_version => 6,
    :mobile_device => false,
    :parent => "Firefox 3.6",
    :platform => "MacOSX",
    :platform_version => 10.6,
    :rendering_engine_name => "Gecko",
    :rendering_engine_version => "1.9.2",
    :rendering_engine_description => "For Firefox, Camino, K-Meleon, SeaMonkey, Netscape, and other Gecko-based browsers.",
    :syndication_reader => false,
    :tables => true,
    :tablet => false,
    :user_agent => "Mozilla/5.0 (*Mac OS X 10.6*) Gecko/* Firefox/3.6*",
    :user_agent_id => nil,
    :vbscript => false,
    :version => 3.6,
    :win16 => false,
    :win32 => false,
    :win64 => false,
  })

  FIREFOX_ON_OSX.pattern = /^mozilla\/5\.0 \(macintosh; .*; .*mac os x.*; .*; rv:1\.9\.2.*\) gecko\/.* firefox\/3\.6.*$/

  FIREFOX_ON_OSX_USER_AGENT_STRING = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8'.freeze

  def setup
    Browscapper.clear_cache
  end

  def test_browscap_ini
    match = Browscapper.match(FIREFOX_ON_OSX_USER_AGENT_STRING)

    FIREFOX_ON_OSX.each do |k, v|
      assert(v == match[k], " Expected #{v.inspect} for #{k}, got #{match[k].inspect}")
    end
  end

  def test_match_nil
    assert_nil(Browscapper.match(nil))
  end

  def test_match_empty
    assert_nil(Browscapper.match(""))
  end

  def test_match_to_s
    value = OpenStruct.new

    def value.to_s
      FIREFOX_ON_OSX_USER_AGENT_STRING
    end

    assert_equal(FIREFOX_ON_OSX, Browscapper.match(value))
  end

  def test_browscap_version
    assert_equal(5036, Browscapper.browscap_version)
  end

  def test_browscap_released
    assert_equal(Date.parse("Wed, 19 Nov 2014 21:12:38 +0000"), Browscapper.browscap_released)
  end

  def test_browscap_format
    assert_equal("php", Browscapper.browscap_format)
  end

  def test_browscap_type
    assert_equal("FULL", Browscapper.browscap_type)
  end
end
