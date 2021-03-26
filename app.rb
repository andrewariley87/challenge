require 'pry'
require 'csv'

class App
  attr_reader :dictionary, :mappings, :words

  def initialize
    @dictionary = add_words_to_dictionary
    @mappings   = {
      '0' => [],
      '1' => [],
      '2' => ['a', 'b', 'c'],
      '3' => ['d', 'e', 'f'],
      '4' => ['g', 'h', 'i'],
      '5' => ['j', 'k', 'l'],
      '6' => ['m', 'n', 'o'],
      '7' => ['p', 'q', 'r', 's'],
      '8' => ['t', 'u', 'v'],
      '9' => ['w', 'x', 'y', 'z']
    }
    @words = []
  end
  def perform(input)
    ARGV.each   { |phone_number| spell_number(phone_number) }
    puts words.join(', ')
  end

  private

  def spell_number(phone_number)
    phone_number_array = phone_number.split('')
    dictionary.each do |word|
      letters = word.split('')
      phone_number_array.each_with_index do |number, index|
        return if !mappings[number].include?(letters[index]) || phone_number_array.length != letters.length
        words << word if (index + 1) == phone_number_array.length
      end
    end
  end

  def add_words_to_dictionary
    words = []
    CSV.foreach('dictionary.csv', headers: true) { |row| words << row['word'].downcase }
    words
  end
end
App.new.perform(ARGV)