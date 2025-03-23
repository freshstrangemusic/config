function patisserie --description "Use patisserie to paste to pastery.net"
  set _PATISSERIE (which patisserie)
  set -x PASTERY_API_KEY (op item get pastery-api-key --fields credential --reveal)

  $_PATISSERIE $argv
end
