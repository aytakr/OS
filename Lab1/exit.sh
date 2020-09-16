function ex {
  if [[ $1 -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр exit не имеет дополнительных аргументов"
    argumentError
  fi
  exit 0
}
