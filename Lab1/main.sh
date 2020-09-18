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
} #ошибки в неинтерактивном режиме
function checkFile {
  if ! [[ -e $1.sh ]]
  then
    echo -e "\033[31mОшибка - нет файла $1.sh"
    noFileError
  fi
  if ! [[ -r $1.sh ]]
  then
    echo -e "\033[31mОшибка - недостаточно прав для запуска $1.sh"
    accessError
  fi
} #проверка файлов .sh в неинтерактивном режиме
case $1 in
calc)
  checkFile $1
  . ./calc.sh
  calc $2 $3 $4 $#
  exit 0
;;
search)
  checkFile $1
  . ./search.sh
  search $2 $3 $#
  exit 0
;;
reverse)
  checkFile $1
  . ./reverse.sh
  rev $2 $3 $#
  exit 0
;;
strlen)
  checkFile $1
  . ./strlen.sh
  strlen "$2" $#
  exit 0
;;
log)
  checkFile $1
  . ./log.sh
  log $#
  exit 0
;;
exit)
  checkFile $1
  . ./exit.sh
  ex $2 $#
;;
help)
  checkFile $1
  . ./help.sh
  help $#
  exit 0
;;
interactive)
  checkFile $1
  . ./interactive.sh
  interactive $#
  exit 0
;;
*)
  if ! [[ -z $1 ]]
  then
    echo "Нет параметра $1"
  fi
  var="help"
  checkFile $var
  . ./help.sh
  help 1
;;
esac
