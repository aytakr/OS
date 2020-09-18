function ex {
  if [[ $2 -gt 2 ]]
  then
    echo -e "\033[31mОшибка - слишком много аргументов\033[0m"
    argumentError
  fi
  if [[ -z $1 ]]
  then
    echo "0"
    exit 0
  fi
  re='^-?[0-256]+$'
  if ! [[ "$1" =~ $re ]]
  then
    echo -e "\033[31mОшибка - введите параметр выхода (число от -256 до 256)\033[0m"
    argumentError
  fi
  if [[ $1 -lt 0 ]]
  then
    exit $1
  fi
  exit $1
}
