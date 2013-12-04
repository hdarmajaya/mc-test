McTest::Application.routes.draw do
  get "search_suggestion/index"

  get "dashboard/index"

  root to: 'dashboard#index'
end
