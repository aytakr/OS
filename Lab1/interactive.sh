function interactive {
  var1=5
  if ! [[ -e help ]]
  then
    echo "Ошибка - нет файла help"
    noFileError
  fi
  if ! [[ -r help ]]
  then
    echo "Ошибка - недостаточно прав для запуска help"
    accessError
  fi
  . ./help
  help
  while [ $var1 -gt 0 ]
  do
    read code
    case $code in
    calc)
      echo "Введите sum/sub/mul/div и два целых числа или back, чтобы вернуться назад"
      read arg2 arg3 arg4 arg5
      if [[ $arg2 = "back" && -n $arg3 ]]
      then
        echo "Ошибка - неправильное количество аргументов. После $arg2 нет аргументов"
        argumentError
      fi
      if [[ $arg2 = "back" ]]
      then
        continue
      fi
      if ! [[ -e $code ]]
      then
        echo "Ошибка - нет файла $code"
        noFileError
      fi
      if ! [[ -r $code ]]
      then
        echo "Ошибка - недостаточно прав для запуска $code"
        accessError
      fi
      if [[ -n $arg5 || -z $arg2 || -z $arg3 || -z $arg4 ]]
      then
        echo "Ошибка - неправильное количество аргументов. После $code введите sum/sub/mul/div и два целых числа"
        argumentError
      fi
      re='^[0-9]+$'
      if ! [[ "$arg3" =~ $re && "$arg4" =~ $re ]]
      then
        echo "Ошибка - Неверный третий или четверный аргумент. Выберите в качестве третьего и четвертого аргументов целое число"
        argumentError
      fi
      if [[ $arg2 = "div" && $arg4 -eq 0 ]]
      then
        echo "Ошибка - деление на ноль невозможно"
        mathError
      fi
      if [[ "$arg2" != "sum" && "$arg2" != "sub" && "$arg2" != "mul" && "$arg2" != "div" ]]
      then
        echo "Ошибка - Неверный аргумент действия. Введите sum/sub/mul/div"
        argumentError
      fi
      . ./calc
      res=$($arg2 $arg3 $arg4)
      echo "$res"
    ;;
    search)
      echo "Введите директорию и строку или регулярное выражение или back, чтобы вернуться назад:"
      read arg2 arg3 arg4
      if [[ $arg2 = "back" && -n $arg3 ]]
      then
        echo "Ошибка - неправильное количество аргументов. После $arg2 нет аргументов"
        argumentError
      fi
      if [[ $arg2 = "back" ]]
      then
        continue
      fi
      if ! [[ -e $code ]]
      then
        echo "Ошибка - нет файла $code"
        noFileError
      fi
      if ! [[ -r $code ]]
      then
        echo "Ошибка - недостаточно прав для запуска $code"
        accessError
      fi
      if [[ -n $arg4 || -z $arg2 || -z $arg3 ]]
      then
        echo "Ошибка - неправильное количество аргументов. Введите директорию и строку или регулярное выражение или back, чтобы вернуться назад"
        argumentError
      fi
      if ! [[ -d $arg2 ]]
      then
        echo "Ошибка - такой директории не существует"
        noDirectoryError
      fi
      if ! [[ -r $arg2 ]]
      then
        echo "Ошибка - недостаточно прав для открытия $2"
        accessError
      fi
      . ./search
      search $arg2 $arg3
    ;;
    reverse)
      echo "Введите названия двух файлов или back, чтобы вернуться:"
      read arg2 arg3 arg4
      if [[ $arg2 = "back" && -n $arg3 ]]
      then
        echo "Ошибка - неправильное количество аргументов. После $arg2 нет аргументов"
        argumentError
      fi
      if [[ $arg2 = "back" ]]
      then
        continue
      fi
      if ! [[ -e $code ]]
      then
        echo "Ошибка - нет файла $code"
        noFileError
      fi
      if ! [[ -r $code ]]
      then
        echo "Ошибка - недостаточно прав для запуска $code"
        accessError
      fi
      if [[ -n $arg4 || -z $arg2 || -z $arg3 ]]
      then
        echo "Ошибка - неправильное количество аргументов. Введите названия двух файлов"
        argumentError
      fi
      files=($(ls))
      flag1=0
      flag2=0
      for file in "${files[@]}"
      do
        if [[ "$file" == "$arg2" ]]
        then
          flag1=1
        fi
        if [[ "$file" == "$arg3" ]]
        then
          flag2=1
        fi
      done
      if [[ $flag1 -ne 1 || $flag2 -ne 1 ]]
      then
        echo "Ошибка - нет файла $arg2 или $arg3."
        noFileError
      fi
      . ./reverse
      rev $arg2 $arg3
    ;;
    strlen)
      echo "Введите строку или back, чтобы вернуться"
      read arg2 arg3
      if [[ $arg2 = "back" && -n $arg3 ]]
      then
        echo "Ошибка - неправильное количество аргументов. После $arg2 нет аргументов"
        argumentError
      fi
      if [[ $arg2 = "back" ]]
      then
        continue
      fi
      if ! [[ -e $code ]]
      then
        echo "Ошибка - нет файла $code"
        noFileError
      fi
      if ! [[ -r $code ]]
      then
        echo "Ошибка - недостаточно прав для запуска $code"
        accessError
      fi
      if [[ -n $arg3 ]]
      then
        echo "Ошибка - неправильное количество аргументов. Введите названия двух файлов"
        argumentError
      fi
      . ./strlen
      echo "$(strlen $arg2)"
    ;;
    log)
      if ! [[ -e $code ]]
      then
        echo "Ошибка - нет файла $code"
        noFileError
      fi
      if ! [[ -r $code ]]
      then
        echo "Ошибка - недостаточно прав для запуска $code"
        accessError
      fi
    ;;
    exit)
      if ! [[ -e $code ]]
      then
        echo "Ошибка - нет файла $code"
        noFileError
      fi
      if ! [[ -r $code ]]
      then
        echo "Ошибка - недостаточно прав для запуска $code"
        accessError
      fi
      . ./exit
      ex
    ;;
    help)
      help
    ;;
    esac
  done
}
