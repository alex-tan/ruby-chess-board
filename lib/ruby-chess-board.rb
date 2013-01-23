require 'rubygems'
require 'bundler'

Bundler.require(:default)

require_relative 'ruby-chess-board/piece'
require_all "lib/ruby-chess-board/pieces"

require_relative 'ruby-chess-board/board'
require_all "lib/ruby-chess-board/"
