# encoding: BINARY

$: << './lib'

require 'rubygems'
require 'minitest/autorun'
require './lib/browscapper'

class BrowscapperTest < MiniTest::Unit::TestCase
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
    :device_name => "unknown",
    :device_maker => "unknown",
    :frames => true,
    :iframes => true,
    :java_applets => true,
    :javascript => true,
    :major_version => 3,
    :minor_version => 6,
    :mobile_device => false,
    :parent => "Firefox 3.6",
    :platform => "MacOSX",
    :platform_version => "unknown",
    :rendering_engine_name => "Gecko",
    :rendering_engine_version => "unknown",
    :rendering_engine_description => "For Firefox, Camino, K-Meleon, SeaMonkey, Netscape, and other Gecko-based browsers.",
    :syndication_reader => false,
    :tables => true,
    :user_agent => "Mozilla/5.0 (Macintosh; *; *Mac OS X*; *; rv:1.9.2*) Gecko/* Firefox/3.6*",
    :user_agent_id => nil,
    :vbscript => false,
    :version => "3.6",
    :win16 => false,
    :win32 => false,
    :win64 => false,
  })

  FIREFOX_ON_OSX.pattern = /^mozilla\/5\.0 \(macintosh; .*; .*mac os x.*; .*; rv:1\.9\.2.*\) gecko\/.* firefox\/3\.6.*$/

  def test_browscap_ini
    Browscapper.load(File.join('vendor', 'browscap.dump'))
    match = Browscapper.match('Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8')

    FIREFOX_ON_OSX.each do |k, v|
      assert(v == match[k], " Expected #{v.inspect} for #{k}, got #{match[k].inspect}")
    end
  end
end
