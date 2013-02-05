require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_all "lib/ruby-chess-board/modules"
require_all "lib/ruby-chess-board"
require_all "lib/ruby-chess-board/pieces"

# Contains the RubyChessBoard library.
module RubyChessBoard
end
