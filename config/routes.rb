Googlechat::Application.routes.draw do
  get "static/chat"
  get "static/reply"
  post "static/chat"
  root :to => 'static#chat'
end
