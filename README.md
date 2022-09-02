# README

* System dependencies
  We're using docker here. After install docker you will need to run 
 
  docker-compose build

* Running

 docker-compose up -d
  
* Disclaimer
  
  A maior parte da lógica está no arquivo parser.rb
  No PalestrasController eu coloquei para reenderizar o json dos arquivos sem um redirect pro index.
  Após subir o arquivo o parser lê ele e faz todas as alterações e quando volta para o controller novamente é settado cada track.

