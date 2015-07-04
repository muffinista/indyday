#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot IndyDaySpeech
# generated on 2015-07-03 14:12:42 -0400
#


#tweets = client.user_timeline(count:200).collect(&:id)
#client.destroy_status(tweets)
#exit

data = JSON.parse(File.read("speech.json"))

data.each { |entry|
  puts entry.inspect
  puts entry["line"]

  client.update_with_media entry["line"], File.open(entry["image"]) 
  sleep entry["ticks"].to_i
}
