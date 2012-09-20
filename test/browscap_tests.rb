# encoding: BINARY

$: << './lib'

require 'rubygems'
require 'test/unit'
require './lib/browscap'

class BrowscapTest < Test::Unit::TestCase
  FIREFOX_ON_OSX = Browscap::UserAgent.new({
    :cdf => false,
    :javascript => true,
    :alpha => false,
    :platform => "MacOSX",
    :crawler => false,
    :iframes => true,
    :aol => false,
    :java_applets => true,
    :beta => false,
    :css_version => 3,
    :tables => true,
    :activex_controls => false,
    :win16 => false,
    :aol_version => 0,
    :cookies => true,
    :browser => "Firefox",
    :user_agent =>
     "Mozilla/5.0 (Macintosh; *; *Mac OS X*; *; rv:1.9.2*) Gecko/* Firefox/3.6*",
    :banned => false,
    :win32 => false,
    :parent => "Firefox 3.6",
    :user_agent_id => nil,
    :background_sounds => false,
    :major_version => 3,
    :mobile_device => false,
    :win64 => false,
    :version => "3.6",
    :css => true,
    :pattern => /^mozilla\/5\.0 \(macintosh; .*; .*mac os x.*; .*; rv:1\.9\.2.*\) gecko\/.* firefox\/3\.6.*$/,
    :vbscript => false,
    :minor_version => 6,
    :syndication_reader => false,
    :frames => true
  })

  def test_browscap_ini
    Browscap.load(File.join('vendor', 'browscap.ini'))
    assert(FIREFOX_ON_OSX ==
      Browscap.match('Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8')
    )
  end
end
