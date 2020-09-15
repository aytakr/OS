#! /usr/bin/env bash
var1=5
while [ $var1 -gt 0 ]
do
  . ./menu
  menu


  read code

  case $code in
  calc)
    while [ $var1 -gt 0 ]
    do
      echo "Введите sum/sub/mul/div и два целых числа или back, чтобы вернуться назад"
      read arg2 arg3 arg4
      if [ "$arg2" = "back" ]
      then
        break
      fi
      . ./calc
      res=$($arg2 $arg3 $arg4)
      echo "$res"
    done
    ;;
  search)
    direct=`dir`
    echo "$direct"
    echo "------------------------------"
    cd contest
    echo `dir`
    cd ..
    ;;
  reverse)
    read f1 f2
    t1=`tail $f1`
    echo "$t1"
  esac

done
