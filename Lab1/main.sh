#! /usr/bin/env bash
case $1 in
calc)
  if ! [[ -e $1 ]]
  then
    echo "Ошибка - нет файла calc"
    exit 0
  fi
  if ! [[ -r $1 ]]
  then
    echo "Ошибка - недостаточно прав для запуска calc"
    exit 0
  fi
  if [[ $# -ne 4 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После $1 введите sum/sub/mul/div и два целых числа"
    exit 0
  fi
  re='^[0-9]+$'
  if ! [[ "$3" =~ $re && "$4" =~ $re ]]
  then
    echo "Ошибка - Неверный третий или четверный аргумент. Выберите в качестве третьего и четвертого аргументов целое число"
    exit 0
  fi
  if [[ "$2" = "div" && $4 -eq 0 ]]
  then
    echo "Ошибка - деление на ноль невозможно"
    exit 0
  fi
  if [[ "$2" != "sum" && "$2" != "sub" && "$2" != "mul" && "$2" != "div" ]]
  then
    echo "Ошибка - Неверный второй аргумент. Выберите вторым аргументом sum/sub/mul/div"
    echo "$2"
    exit 0
  fi
  . ./calc
  res=$($2 $3 $4)
  echo "$res"
  exit 0
;;
search)
  if [[ $# -ne 3 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После $1 введите название директории и регулярное выражение"
    exit 0
  fi
  exit 0
;;
reverse)
  if [[ $# -ne 3 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После $1 введите названия двух файлов"
    exit 0
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
    echo "Ошибка - таких файлов нет в директории."
    exit 0
  fi
  . ./reverse
  $(rev $2 $3)
  exit 0
;;
strlen)
  if [[ $# -ne 2 ]]
  then
    echo "Ошибка - неправильное количество аргументов. После strlen введите строку"
    exit 0
  fi
  . ./strlen
  echo "$(strlen $2)"
  exit 0
;;
log)
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    exit 0
  fi
  exit 0
;;
exit)
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    exit 0
  fi
  exit 0
;;
help)
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    exit 0
  fi
  . ./menu
  menu
  exit 0
;;
interactive)
  if [[ $# -ne 1 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Параметр $1 не имеет дополнительных аргументов"
    exit 0
  fi
  . ./interactive
  interactive
  exit 0
;;
esac
