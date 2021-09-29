require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_all "lib/ruby-chess-board/modules"
require "ruby-chess-board/piece"
require_all "lib/ruby-chess-board/pieces"
require_all "lib/ruby-chess-board"

# Contains the RubyChessBoard library.
module RubyChessBoard
end
