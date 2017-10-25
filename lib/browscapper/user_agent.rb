# frozen_string_literal: true
# encoding: BINARY

module Browscapper
  class UserAgent
    include Enumerable

    ACCESSORS = [
      :parent, :user_agent, :comment, :browser, :version, :major_version,
      :minor_version, :platform, :platform_version, :alpha, :beta, :win16, :win32, :win64,
      :frames, :iframes, :tables, :cookies, :background_sounds, :vbscript,
      :javascript, :java_applets, :activex_controls, :banned, :mobile_device, :tablet,
      :syndication_reader, :crawler, :css_version, :aol_version, :user_agent_id,
      :css, :cdf, :aol, :device_name, :device_maker, :rendering_engine_name,
      :rendering_engine_version, :rendering_engine_description
    ]

    ACCESSORS.each do |accessor|
      self.class_eval do
        attr_accessor accessor
      end
    end

    attr_accessor :pattern

    MAP = {
      'propertyname'         => :property_name,
      'useragent'            => :user_agent,
      'version'              => :version,
      'majorver'             => :major_version,
      'minorver'             => :minor_version,
      'majorversion'         => :major_version,
      'minorversion'         => :minor_version,
      'backgroundsounds'     => :background_sounds,
      'javaapplets'          => :java_applets,
      'activexcontrols'      => :activex_controls,
      'isbanned'             => :banned,
      'ismobiledevice'       => :mobile_device,
      'mobiledevice'         => :mobile_device,
      'issyndicationreader'  => :syndication_reader,
      'syndicationreader'    => :syndication_reader,
      'cssversion'           => :css_version,
      'aolversion'           => :aol_version,
      'useragentid'          => :user_agent_id,
      'supportscss'          => :css,
      'renderingengine_name' => :rendering_engine_name,
      'renderingengine_version' => :rendering_engine_version,
      'renderingengine_description' => :rendering_engine_description,
      'istablet'             => :tablet
    }

    def initialize(hash = {})
      self.merge!(hash)
    end

    def each
      self.to_hash.each do |k, v|
        yield k, v
      end
    end

    def to_hash
      @to_hash ||= ACCESSORS.inject({}) do |memo, accessor|
        memo[accessor] = self.send(accessor)
        memo
      end
    end

    def []=(key, value)
      key = key.to_s.downcase
      key = "#{MAP[key] || key}="
      self.send(key, value) if self.respond_to?(key)
    end

    def [](key)
      key = key.to_s.downcase
      key = MAP[key] || key
      self.send(key) if self.respond_to?(key)
    end

    def merge!(parent)
      parent = parent.to_hash if parent.is_a?(UserAgent)
      ACCESSORS.each do |k, v|
        if parent.has_key?(k)
          val = self.send(k)
          if val == 'default' || val.nil?
            self.send("#{k}=", parent[k])
          end
        end
      end
      self
    end

    def ==(other)
      return false unless other.is_a?(self.class)

      ACCESSORS.each do |accessor|
        return false if self.send(accessor) != other.send(accessor)
      end
      true
    end
  end
end
