function ex {
  if [[ $2 -gt 2 ]]
  then
    echo -e "\033[31mОшибка - слишком много аргументов\033[0m"
    argumentError
  fi
  re='^-?[0-256]+$'
  if ! [[ "$1" =~ $re ]] || [[ "$1" =~ $re && "$1" -gt 256 ]] || [[ "$1" =~ $re && "$1" -lt -256 ]]
  then
    echo -e "\033[31mОшибка - введите параметр выхода (число от -256 до 256)\033[0m"
    if [[ "$3" = "interactive" ]]
    then
      argumentError_int
      return $?
    fi
    argumentError
  fi
  if [[ $1 -eq 1 ]]
  then
    if [[ "$2" = "interactive" ]]
    then
      exit 0
    fi
    if ! [[ $2 ]]
    then
      exit 0
    fi
  fi
  exit $1
}
