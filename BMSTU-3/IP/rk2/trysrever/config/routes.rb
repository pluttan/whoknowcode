Rails.application.routes.draw do
  root "page1#index"
  get "/result", to: "page2#result"
end
