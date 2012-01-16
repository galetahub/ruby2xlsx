Dummy::Application.routes.draw do
  resources :articles

  match "/another(.:format)", :to => "articles#another", :as => :another
  match "/empty(.:format)", :to => "articles#empty", :as => :empty
end
