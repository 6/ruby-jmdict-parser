#encoding: utf-8
require 'json'

ec = Encoding::Converter.new("euc-jp", "utf-8")

radical_kanjis = {}
kanji_radicals = {}
current_radical = nil

File.open("data/radkfilex").each do |line|
  next  if line.start_with?("#") # ignore comments

  line = ec.convert(line)
  if line.start_with?("$") # reached a new radical
    current_radical = line.split[1]
    radical_kanjis[current_radical] = []
  else
    kanjis = line.split(//)
    kanjis.pop # remove \n

    radical_kanjis[current_radical].concat(kanjis)
    kanjis.each do |kanji|
      kanji_radicals[kanji] ||= []
      kanji_radicals[kanji] << current_radical
    end
  end
end

def write_json(fname, hash)
  File.open("json-output/#{fname}", 'w') do |f|
    f.write(hash.to_json)
  end
end

write_json('kanji_radicals.json', kanji_radicals)
write_json('radical_kanjis.json', radical_kanjis)
