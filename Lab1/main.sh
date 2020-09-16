#! /usr/bin/env bash
function noFileError {
  exit -1
}
function accessError {
  exit -2
}
function argumentError {
  exit -3
}
function mathError {
  exit -4
}
function noDirectoryError {
  exit -5
}
case $1 in
calc)
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла $1"
    noFileError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1"
    accessError
  fi
  if [[ $# -ne 4 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После $1 введите sum/sub/mul/div и два целых числа"
    argumentError
  fi
  re='^[0-9]+$'
  if ! [[ "$3" =~ $re && "$4" =~ $re ]]
  then
    echo "Ошибка - Неверный третий или четверный аргумент. Выберите в качестве третьего и четвертого аргументов целое число"
    argumentError
  fi
  if [[ "$2" = "div" && $4 -eq 0 ]]
  then
    echo "Ошибка - деление на ноль невозможно"
    mathError
  fi
  if [[ "$2" != "sum" && "$2" != "sub" && "$2" != "mul" && "$2" != "div" ]]
  then
    echo "Ошибка - Неверный второй аргумент. Выберите вторым аргументом sum/sub/mul/div"
    argumentError
  fi
  . ./calc
  res=$($2 $3 $4)
  echo "$res"
  exit 0
;;
search)
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла $1"
    noFileError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1"
    accessError
  fi
  if [[ $# -ne 3 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После $1 введите название директории и регулярное выражение"
    argumentError
  fi
  if ! [[ -d $2 ]]
  then
    echo "Ошибка - такой директории не существует"
    noDirectoryError
  fi
  if ! [[ -r $2 ]]
  then
    echo "Ошибка - недостаточно прав для открытия $2"
    accessError
  fi
  . ./search
  search $2 $3
  exit 0
;;
reverse)
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла $1"
    noFileError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1"
    accessError
  fi
  if [[ $# -ne 3 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После $1 введите названия двух файлов"
    argumentError
  fi
  files=($(ls))
  flag1=0
  flag2=0
  for file in "${files[@]}"
  do
    if [[ "$file" == "$2" ]]
    then
      flag1=1
    fi
    if [[ "$file" == "$3" ]]
    then
      flag2=1
    fi
  done
  if [[ $flag1 -ne 1 || $flag2 -ne 1 ]]
  then
    echo "Ошибка - нет файла $2 или $3."
    noFileError
  fi
  . ./reverse
  rev $2 $3
  exit 0
;;
strlen)
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла $1"
    noFileError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1"
    accessError
  fi
  if [[ $# -ne 2 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После strlen введите строку"
    argumentError
  fi
  . ./strlen
  echo "$(strlen $2)"
  exit 0
;;
log)
  if ! [[ -e $1.sh ]]
  then
    echo "Ошибка - нет файла $1.sh"
    noFileError
  fi
  if ! [[ -r $1.sh ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1.sh"
    accessError
  fi
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    argumentError
  fi
  . ./log.sh
  log
  exit 0
;;
exit)
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла $1"
    noFileError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1"
    accessError
  fi
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    argumentError
  fi
  . ./exit
  ex
;;
help)
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла $1"
    noFileError
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1"
    accessError
  fi
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    argumentError
  fi
  . ./help
  help
  exit 0
;;
interactive)
  if ! [[ -e $1.sh ]]
  then
    echo "Ошибка - нет файла $1.sh"
    noFileError
  fi
  if ! [[ -r $1.sh ]]
  then
    echo "Ошибка - недостаточно прав для запуска $1.sh"
    accessError
  fi
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    argumentError
  fi
  . ./interactive.sh
  interactive
  exit 0
;;
*)
  if ! [[ -e "help" ]]
  then
    echo "Ошибка - нет файла help"
    noFileError
  fi
  if ! [[ -r "help" ]]
  then
    echo "Ошибка - недостаточно прав для запуска help"
    accessError
  fi
  . ./help
  help
;;
esac
