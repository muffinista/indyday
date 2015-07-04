#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot IndyDaySpeech
# generated on 2015-07-03 14:12:42 -0400
#

data = JSON.parse(File.read("speech.json"))

last_tweet = nil

data.each { |entry|
  puts entry.inspect
  puts entry["line"]

  opts = {}
  if last_tweet
   opts[:in_reply_to_status_id] = last_tweet.id
   last_tweet = client.update_with_media entry["line"], File.open(entry["image"]), opts
  else
   last_tweet = client.update_with_media entry["line"], File.open(entry["image"])
  end




  sleep entry["ticks"].to_i
}
