#! /usr/bin/env bash
case $1 in
calc)
  if [[ $# -ne 4 ]]
  then
    echo "Ошибка - неправильное количество аргументов. Введите sum/sub/mul/div и два целых числа"
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

  exit 0
;;
reverse)

  exit 0
;;
strlen)
  echo "$2" | awk '{print length}'
  exit 0
;;
exit)
  exit 0
;;
help)
  . ./menu
  menu
  exit 0
;;
esac
