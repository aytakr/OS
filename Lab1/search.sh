function search {
  if [[ $3 -ne 3 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После search введите название директории и регулярное выражение"
    argumentError
  fi
  if ! [[ -d $1 ]]
  then
    echo "Ошибка - такой директории не существует"
    noDirectoryError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для открытия $1"
    accessError
  fi
  grep -r "$2" "$1"
}
