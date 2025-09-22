class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def win?  = check_win_or_lose == :win

  def lose? = check_win_or_lose == :lose

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # record a guess; return true if it changed state, false if it was a repeat
  def guess(letter)
    # invalid inputs raise ArgumentError
    raise ArgumentError if letter.nil? || letter.empty? || letter =~ /[^a-zA-Z]/
  
    letter = letter.downcase
  
    # repeated guess? no state change
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
  
    if @word.downcase.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    true
  end
  
  # reveal guessed letters; dashes for unknowns
  def word_with_guesses
    @word.chars.map { |ch| @guesses.include?(ch.downcase) ? ch : '-' }.join
  end
  
  # game status
  def check_win_or_lose
    return :win  if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7
    :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
