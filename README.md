# README

* Ruby version 
  3.0.2
  
* Rails version 6.1.6.1

* System dependencies

  gem "pg", '~> 1.4.3'
  postgresql 14.4

* Database creation

  rake db:create
  rake db:migrate
  
  
* Disclaimer
  
  A maior parte da lógica está no arquivo parser.rb
  No PalestrasController eu coloquei para reenderizar o json dos arquivos sem um redirect pro index.
  Após subir o arquivo o parser lê ele e faz todas as alterações e quando volta para o controller novamente é settado cada track.

