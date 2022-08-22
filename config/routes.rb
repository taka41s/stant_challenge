Rails.application.routes.draw do
  resources :palestras

  root to: "palestras#index"

  get "/upload" => "palestras#upload"
  post "/upload" => "palestras#converted_upload_to_json"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
