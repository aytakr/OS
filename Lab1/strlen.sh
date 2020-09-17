function strlen {
  if [[ $1 = "interactive" ]] # интеративный режим
  then
    if [[ -n $3 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. После strlen введите строку\033[0m"
      argumentError_int
      return $?
    fi
    echo "$2" | awk '{print length}'
  else # неинтерактивный режим
    if [[ $2 -gt 2 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. После strlen введите строку\033[0m"
      argumentError
    fi
    echo "$1" | awk '{print length}'
  fi
}
