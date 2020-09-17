function search {
  if [[ "$1" = "interactive" ]] #интерактивный режим
  then
    if [[ -n $4 || -z $2 || -z $3 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. Введите директорию и строку или регулярное выражение, или back, чтобы вернуться назад\033[0m"
      argumentError_int
      return $?
    fi
    if ! [[ -d $2 ]]
    then
      echo -e "\033[31mОшибка - такой директории не существует\033[0m"
      noDirectoryError_int
      return $?
    fi
    if ! [[ -r $2 ]]
    then
      echo -e "\033[31mОшибка - недостаточно прав для открытия $2\033[0m"
      accessError_int
      return $?
    fi
    grep -r "$3" "$2"
  else # неинтерактивный режим
    if [[ $3 -ne 3 ]]
    then
      echo -e "\033[31mОшибка - неправильное количество аргументов. После search введите название директории и регулярное выражение\033[0m"
      argumentError
    fi
    if ! [[ -d $1 ]]
    then
      echo -e "\033[31mОшибка - такой директории не существует\033[0m"
      noDirectoryError
    fi
    if ! [[ -r $1 ]]
    then
      echo -e "\033[31mОшибка - недостаточно прав для открытия $1\033[0m"
      accessError
    fi
    grep -r "$2" "$1"
  fi
}
