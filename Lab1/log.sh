function log {
  if [[ $1 -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр log не имеет дополнительных аргументов"
    argumentError
  fi
}
