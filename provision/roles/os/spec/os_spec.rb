# frozen_string_literal: true

require 'spec_helper'

describe command('defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag') do
  its(:stdout) { should match '1' }
end
describe command('defaults read com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag') do
  its(:stdout) { should match '1' }
end
describe command('defaults read com.apple.AppleMultitouchTrackpad Clicking') do
  its(:stdout) { should match '1' }
end
describe command('defaults read com.apple.finder AppleShowAllFiles') do
  its(:stdout) { should match 'True' }
end
describe command('defaults read com.apple.dock show-recents') do
  its(:stdout) { should match '0' }
end
describe command('defaults read com.apple.desktopservices DSDontWriteNetworkStores') do
  its(:stdout) { should match 'True' }
end
describe command('defaults read com.apple.dock autohide') do
  its(:stdout) { should match '1' }
end
describe command('defaults read com.apple.menuextra.battery ShowPercent') do
  its(:stdout) { should match 'True' }
end
describe command('defaults read com.apple.finder ShowPathbar') do
  its(:stdout) { should match '1' }
end
describe command('defaults read com.apple.spaces spans-displays') do
  its(:stdout) { should match '1' }
end
