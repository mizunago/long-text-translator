# frozen_string_literal: false

require_relative 'deepl_trans'
require 'dotenv'

Dotenv.load
DEEPL_AUTH_KEY = ENV['DEEPL_AUTH_KEY']
DEEPL_PRO = ENV['DEEPL_PRO'].downcase == 'true'

# src_file: input English text file
# dest_file: output Localized text file
# lang: Languages supported at DeepL. Example: EN-US, FR, JA
class EnglishBook
  def initialize(src_file, dest_file, lang: 'JA')
    @src_file = File.open(src_file, 'r')
    @dest_file = File.open(dest_file, 'w')
    @deepl = DeeplTranslator.new(DEEPL_AUTH_KEY, paid: DEEPL_PRO)
    @lang = lang
  end

  # 文章で切る
  def sep_chapters(body)
    chapters = body.chomp.split('.')
    chapters.reject do |chapter|
      ["\n", ''].include?(chapter)
    end
  end

  # 5000 文字以下のいい感じの長さの文章を作る
  def collect_under_5000_characters(chapters)
    new_chapters = []
    chapter = ''
    loop do
      if chapter.length + chapters.first.length >= 5000
        new_chapters << chapter
        chapter = ''
      else
        chapter << chapters.shift
        if chapters.empty?
          new_chapters << chapter
          break
        end
      end
    end
    new_chapters
  end

  def dispatch
    chapters = sep_chapters(@src_file.read)
    chapters = collect_under_5000_characters(chapters)

    chapters.each do |chapter|
      body = @deepl.trans(chapter, @lang)
      @dest_file.puts(body)
    end
  end
end

sot = EnglishBook.new('./eng.txt', './jpn.txt', lang: 'JA')
sot.dispatch
puts 'done.'
