#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

require 'mastodon'
token = ENV["MASTODON_TOKEN"]
client = Mastodon::REST::Client.new(base_url: 'https://botsin.space', bearer_token:token)


#
# this is the script for the twitter bot IndyDaySpeech
# generated on 2015-07-03 14:12:42 -0400
#

output = "Good Morning. I'll give a speech sometime in the morning of July 4th."

tweet output
client.create_status(output)


