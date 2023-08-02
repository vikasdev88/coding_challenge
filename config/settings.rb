# frozen_string_literal: true

# Settings is a class that provides access to Rails configuration settings.yml using method_missing.
# It delegates the method calls to the Rails configuration's settings hash.
class Settings
  def self.method_missing(name, *_args, &_block)
    Rails.configuration.settings.send(:[], name)
  end

  def self.respond_to_missing?(name)
    Rails.configuration.settings.key?(name) || super
  end
end
