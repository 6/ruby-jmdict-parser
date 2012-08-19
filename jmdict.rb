#encoding: utf-8

class RadKParser
  attr_reader :radical_kanjis, :kanji_radicals

  def initialize(fpath)
    @ec = Encoding::Converter.new("euc-jp", "utf-8")
    @radical_kanjis = {}
    @kanji_radicals = {}
    parse(fpath)
  end

  def find_kanjis_by_radical(radical)
    @radical_kanjis[radical] || []
  end

  def find_radicals_by_kanji(kanji)
    @kanji_radicals[kanji] || []
  end

  def each_kanji(&blk)
    @kanji_radicals.keys.each &blk
  end

  def each_radical(&blk)
    @radical_kanjis.keys.each &blk
  end

  private

  def parse(fpath)
    current_radical = nil
    File.open(fpath).each do |line|
      next  if line.start_with?("#") # ignore comments

      line = @ec.convert(line)
      if line.start_with?("$") # reached a new radical
        current_radical = line.split[1]
        @radical_kanjis[current_radical] = []
      else
        kanjis = line.split(//)
        kanjis.pop # remove \n

        @radical_kanjis[current_radical].concat(kanjis)
        kanjis.each do |kanji|
          @kanji_radicals[kanji] ||= []
          @kanji_radicals[kanji] << current_radical
        end
      end
    end
  end

end
