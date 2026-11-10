function patisserie --description "Use patisserie to paste to pastery.net"
  env PASTERY_API_KEY="op://private/pastery-api-key/credential" op run (which patisserie) -- $argv
end
