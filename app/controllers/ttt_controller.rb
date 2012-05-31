require 'stompyttt/player'
require 'stompyttt/computer'
require 'stompyttt/narrator'
require 'stompyttt/player_helper'
require 'stompyttt/game'
require 'stompyttt/board'

class TttController < ApplicationController

	def new
  end

  def create
  	if !params[:player_name].blank? && params[:turn].to_i > 0 && params[:turn].to_i < 3
    	session[:turn] = params[:turn].to_i
  		session[:player_name] = params[:player_name]
    	session[:move_count] = 0
    	session[:board] = [" ", " ", " ", " ", " ", " ", " ", " "]
		else
  		redirect_to('new') and return
		end
		render :action => "game"
  end

  def game
  	player_up = session[:move_count]%2 == 0 ? 1 : 2
  	if player_up != session[:turn]
  		return redirect_to("computer_move")
  	end
  end

  def move
  	if session[:board][params[:space].to_i] == " "
  		session[:board][params[:space].to_i] = session[:turn].to_i == 1 ? "X" : "O"
  		session[:move_count] += 1
  	end
  	redirect_to :action => "game"
  end

  def computer_move
  	board = Stompyttt::Board.new(3)
  	board.board = session[:board]
  	board.game_state
  	space = Stompyttt::Computer.get_move(board)

  	session[:board][space] = session[:turn] == 1 ? "O" : "X"
  	session[:move_count] += 1
  	redirect_to :action => "game"
  end

end
