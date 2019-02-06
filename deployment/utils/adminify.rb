#!/usr/bin/env ruby
# manipulates apikey for a user

NCBO_CRON_PATH='/srv/ncbo/ncbo_cron'

# Script uses ncbo_cron for changing apikey becase its easier then
# working with the API since it requires deleting/re-creating user.
# NOTE: ontoportal stack might need to be restarted after this is run.

Dir.chdir NCBO_CRON_PATH

# Exit cleanly from an early interrupt
Signal.trap("INT") { exit! }

# Setup the bundled gems in our environment
require 'bundler/setup'
require 'securerandom'

# Get cron configuration.
require "#{NCBO_CRON_PATH}/lib/ncbo_cron"
require "#{NCBO_CRON_PATH}/config/config.rb";

require_relative 'useradmin.rb'

input_array = ARGV
username = input_array[0]
if input_array.length == 0
  puts "usage: #1 username"
  exit 1
end

adminify(username)