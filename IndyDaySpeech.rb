#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

require 'mastodon'
token = ENV["MASTODON_TOKEN"]
mastodon = Mastodon::REST::Client.new(base_url: 'https://botsin.space', bearer_token:token)


#
# this is the script for the twitter bot IndyDaySpeech
# generated on 2015-07-03 14:12:42 -0400
#

data = JSON.parse(File.read("speech.json"))

last_tweet = nil
last_status = nil

data.each { |entry|
  puts entry.inspect
  puts entry["line"]

  opts = {}
  if last_tweet
    opts[:in_reply_to_status_id] = last_tweet.id
    f = File.open(entry["image"])
    last_tweet = client.update_with_media entry["line"], f, opts
  else
    f = File.open(entry["image"])
    last_tweet = client.update_with_media entry["line"], f
  end

  sleep entry["ticks"].to_i
}


data.each { |entry|
  puts entry.inspect
  puts entry["line"]

  opts = {}
  if last_status
    f = File.open(entry["image"])
    media = mastodon.upload_media(f)

    last_status =  mastodon.create_status(
      entry["line"],
      in_reply_to_id: last_status.id,
      media_ids: [ media.id ]
    )
  else
    f = File.open(entry["image"])
    media = mastodon.upload_media(f)
    last_status = mastodon.create_status(entry["line"], nil, [ media.id ])
  end

  sleep entry["ticks"].to_i
}
