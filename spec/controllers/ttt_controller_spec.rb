require 'spec_helper'

describe TttController do

  describe "New" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "Create" do
  	
  	it "creates everything in the session correctly" do
  		post :create, {:player_name => "Alex", :turn => 1}
    	session[:player_name].should == "Alex"
    	session[:turn].should == 1
    	session[:move_count].should == 0
    	session[:board].should == [" ", " ", " ", " ", " ", " ", " ", " "]
  	end

  	it "validates name to be entered" do
  		post :create, {:player_name => "", :turn => 1}
  		session[:player_name].should_not == ""
  	end

  	it "validates turn to be 1 or 2" do
  		post :create, {:player_name => "Alex", :turn => 5}
  		session[:turn].should_not == 5
  	end

  	it "plays first if turn is 2" do
  		post :create, {:player_name => "Alex", :turn => 2}
    	session[:board].should_not == [" ", " ", " ", " ", " ", " ", " ", " "]
  	end

  end

  describe "Move" do

  	before(:each) do
  		post :create, {:player_name => "Alex", :turn => 2}
  	end

  	it "updates board with valid move" do
  		post :move, {:space => 0}
  		session[:board].should == ["O", " ", " ", " ", " ", " ", " ", " "]
  	end

  	it "doesn't update board with invalid move" do
  		session[:board] = ["X", " ", " ", " ", " ", " ", " ", " "]
  		session[:move_count] = 1
  		post :move, {:space => 0}
  		session[:board].should == ["X", " ", " ", " ", " ", " ", " ", " "]
  		session[:move_count].should == 1
  	end

  	it "updates move_count" do
  		post :move, {:space => 0}
  		session[:move_count].should == 1
  	end

  end

  describe "Computer Player" do

  	it "makes a blocking move" do
  		post :create, {:player_name => "Alex", :turn => 2}	
  		session[:move_count] = 7
  		session[:board] = ["X", " ", " ", "O", "O", " ", "X", "X", "O"]
      post 'computer_move'
      session[:board].should == ["X", " ", " ", "O", "O", "X", "X", "X", "O"]
  	end

  end

end
