require './lib/ruby-chess-board/piece'
Dir["./lib/ruby-chess-board/pieces/*.rb"].each { |file| require file }

Dir["./lib/ruby-chess-board/*.rb"].each { |file| require file }

