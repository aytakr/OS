function noFileError_int {
  return -1
}
function accessError_int {
  return -2
}
function argumentError_int {
  return -3
}
function mathError_int {
  return -4
}
function noDirectoryError_int {
  return -5
} #ошибки в интерактивном режиме
function checkFile_int {
  if ! [[ -e $1.sh ]]
  then
    echo -e "\033[31mОшибка - нет файла $1.sh"
    return -1
  fi
  if ! [[ -r $1.sh ]]
  then
    echo -e "\033[31mОшибка - недостаточно прав для запуска $1.sh"
    return -2
  fi
  return 0
} #проверка файлов .sh в интерактивном режиме
function backToMenu {
  if [[ $1 = "back" && -n $2 ]]
  then
    echo -e "\033[31mОшибка - неправильное количество аргументов. После $1 нет аргументов"
    argumentError_int
    return $?
  fi
  if [[ $1 = "back" ]]
  then
    return 0
  fi
  return 1
}
function interactive {
  var="interactive"
  if [[ $1 -ne 1 ]]
  then
    echo -e "\033[31mОшибка - неправильное количество аргументов. Параметр interactive не имеет дополнительных аргументов\033[0m"
    argumentError
  fi
  var1=5
  checkFile_int help
  if ! [[ $? -eq 255 || $? -eq 254 ]]
  then
    . ./help.sh
  fi
  echo -e "\033[36mЗапущен интерактивный режим\033[0m"
  while [ $var1 -gt 0 ]
  do
    #help $# $var
    echo -e "\033[36mВыберите параметр запуска: calc/search/reverse/strlen/log/exit/help\033[0m"
    read code
    case $code in
    calc)
      checkFile_int $code
      if [[ $? -eq 255 || $? -eq 254 ]]
      then
        continue
      fi
      echo -e "\033[36mВведите sum/sub/mul/div и два целых числа или back, чтобы вернуться назад\033[0m"
      read arg2 arg3 arg4 arg5
      backToMenu $arg2 $arg3
      if [[ $? -eq 0 || $? -eq 253 ]]
      then
        continue
      fi
      . ./calc.sh
      calc $var $arg2 $arg3 $arg4 $arg5
    ;;
    search)
      checkFile_int $code
      if [[ $? -eq 255 || $? -eq 254 ]]
      then
        continue
      fi
      echo -e "\033[36mВведите директорию и строку или регулярное выражение или back, чтобы вернуться назад\033[0m"
      read arg2 arg3 arg4
      backToMenu $arg2 $arg3
      if [[ $? -eq 0 || $? -eq 253 ]]
      then
        continue
      fi
      . ./search.sh
      search $var $arg2 $arg3 $arg4
    ;;
    reverse)
      checkFile_int $code
      if [[ $? -eq 255 || $? -eq 254 ]]
      then
        continue
      fi
      echo -e "\033[36mВведите названия двух файлов или back, чтобы вернуться\033[0m"
      read arg2 arg3 arg4
      backToMenu $arg2 $arg3
      if [[ $? -eq 0 || $? -eq 253 ]]
      then
        continue
      fi
      . ./reverse.sh
      reverse $var $arg2 $arg3 $arg4
    ;;
    strlen)
      IFS=$''
      checkFile_int $code
      if [[ $? -eq 255 || $? -eq 254 ]]
      then
        continue
      fi
      echo -e "\033[36mВведите строку или back, чтобы вернуться\033[0m"
      read arg2 arg3
      backToMenu $arg2 $arg3
      if [[ $? -eq 0 || $? -eq 253 ]]
      then
        continue
      fi
      . ./strlen.sh
      strlen $var "$arg2" $arg3
    ;;
    log)
      checkFile_int $code
      if [[ $? -eq 255 || $? -eq 254 ]]
      then
        continue
      fi
      . ./log.sh
      log $var
    ;;
    exit)
      checkFile_int $code
      if [[ $? -eq 255 || $? -eq 254 ]]
      then
        continue
      fi
      echo -e "\033[36mВведите код выхода\033[0m"
      read arg2 arg3
      if [[ -n $arg3 ]]
      then
        echo -e "\033[31mОшибка - слишком много аргументов\033[0m"
        continue
      fi
      . ./exit.sh
      ex $arg2 $# $var
    ;;
    help)
      help $# $var
    ;;
    *)
      help $# $var
    ;;
    esac
  done
}
