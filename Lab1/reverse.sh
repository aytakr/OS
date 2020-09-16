function rev {
  if [[ $3 -ne 3 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После reverse введите названия двух файлов"
    argumentError
  fi
  checkUsingFile $1
  checkUsingFile $2
  sort -r "$1" >> "$2"
  echo "$#"
}
