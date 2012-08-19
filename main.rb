#encoding: utf-8
require './jmdict'

radk = RadKParser.new("data/radkfilex")

# test it out
radk.radical_kanjis.each do |radical, kanjis|
  p radical, kanjis
end
