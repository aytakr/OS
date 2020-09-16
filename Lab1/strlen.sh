function strlen {
  if [[ $2 -ne 2 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После strlen введите строку"
    argumentError
  fi
  echo "$1" | awk '{print length}'
}
