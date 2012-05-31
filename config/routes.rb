Ttt::Application.routes.draw do
  
  root :to => 'static_pages#home'

  controller :ttt do
    get 'ttt/new' => :new
    post 'ttt/new' => :create
  end

  get "ttt/game"  
  get "ttt/move/:space" => 'ttt#move'
  get "ttt/computer_move"
  
  get "static_pages/home"
  get "static_pages/help"

end
